//
//  AddBusinessViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 18/09/24.
//

import UIKit
import MapKit
import Firebase
import FirebaseStorage
import RxSwift

protocol AddBusinessViewControllerDelegate: AnyObject {
    func didSaveBusiness()
}

class AddBusinessViewController: UIViewController, ImagePickerViewDelegate {

    // MARK: - Attributes

    var selectedCoordinate: CLLocationCoordinate2D?
    weak var delegate: RemovePinDelegate?
    weak var delegateBusiness: AddBusinessViewControllerDelegate?
    private var selectedImage: UIImage?
    private let loadingSubject = BehaviorSubject<Bool>(value: false)
    private let disposeBag = DisposeBag()
    private var sendControl = false
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?

    // MARK: - UI Components

    private lazy var sheetInfoView: SheetInfoView = {
        let sheetInfoView = SheetInfoView(title: "Adicionar comércio",
                                          subtitle: "Os dados enviados são analisados, se aprovados o comércio é adicionado em até 48 horas.")
        sheetInfoView.translatesAutoresizingMaskIntoConstraints = false
        return sheetInfoView
    }()

    private lazy var inputTextFieldName: InputWithLeftIconView = {
        let view = InputWithLeftIconView(placeholder: "Nome do comércio", icon: "bag")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var inputTextFieldPhone: PhoneNumberView = {
        let view = PhoneNumberView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var inputTextFieldBussinessType: FilterPickerView = {
        let view = FilterPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var inputSelectImageButton: SelectImageButton = {
        let button = SelectImageButton()
        button.delegate = self
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var addBussinessButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        button.setTitle("Adicionar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorsExtension.purpleMedium
        button.layer.cornerRadius = 9
        button.addTarget(self, action: #selector(saveBusinessData), for: .touchUpInside)
        button.layer.shadowColor = ColorsExtension.purpleLight?.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 0
        return button
    }()

    private lazy var loadingView: LoadingView = {
        let loading = LoadingView()
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()

    // MARK: - Functions

    func didSelectImage(_ image: UIImage) {
        selectedImage = image
    }

    @objc func saveBusinessData() {
        guard let name = inputTextFieldName.getValue(), !name.isEmpty,
              let phone = inputTextFieldPhone.getValue(), !phone.isEmpty,
              let businessType = inputTextFieldBussinessType.getValue(), !businessType.isEmpty,
              let lati = self.latitude,
              let long = self.longitude,
              let selectedImage = selectedImage
        else {
            showAlert(on: self, title: "Erro", message: "Por favor preencha todos os campos")
            return
        }

        loadingSubject.onNext(true)

        FirebaseStorageService.shared.uploadImage(image: selectedImage)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] imageUrl in
                guard let self = self else { return }

                self.saveDataToFirestore(name: name, phone: phone, businessType: businessType, latitude: lati, longitude: long, imageUrl: imageUrl)

            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                loadingSubject.onNext(false)
                showAlert(on: self, title: "Erro", message: "Falha ao fazer upload da imagem: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }

    private func saveDataToFirestore(name: String,
                                     phone: String,
                                     businessType: String,
                                     latitude: CLLocationDegrees,
                                     longitude: CLLocationDegrees,
                                     imageUrl: String) {

        FirebaseStorageService.shared.saveBusinessData(name: name,
                                                       phone: phone,
                                                       businessType: businessType,
                                                       latitude: latitude,
                                                       longitude: longitude,
                                                       imageUrl: imageUrl)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] in
                guard let self = self else { return }
                loadingSubject.onNext(false)
                showAlert(on: self, title: "Sucesso", message: "Dados salvos com sucesso!", completion: {
                    self.sendControl = true
                    self.delegateBusiness?.didSaveBusiness()
                    self.dismiss(animated: true, completion: nil)
                })
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                loadingSubject.onNext(false)
                showAlert(on: self, title: "Erro", message: "Erro ao salvar os dados: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if (!sendControl) {
            delegate?.removeTemporaryPin()
        }
    }
}

extension AddBusinessViewController: SetupView {
    func setup() {
        view.backgroundColor = .white
        
        loadingSubject
            .observe(on: MainScheduler.instance)
            .bind { [weak self] isLoading in
                if isLoading {
                    self?.loadingView.startAnimating()
                } else {
                    self?.loadingView.stopAnimating()
                }
            }
            .disposed(by: disposeBag)
        
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(sheetInfoView)
        view.addSubview(inputTextFieldName)
        view.addSubview(inputTextFieldPhone)
        view.addSubview(inputTextFieldBussinessType)
        view.addSubview(inputSelectImageButton)
        view.addSubview(addBussinessButton)
        view.addSubview(loadingView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            sheetInfoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 42),
            sheetInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sheetInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            inputTextFieldName.topAnchor.constraint(equalTo: sheetInfoView.bottomAnchor, constant: 120),
            inputTextFieldName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputTextFieldName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            inputTextFieldPhone.topAnchor.constraint(equalTo: inputTextFieldName.bottomAnchor, constant: 30),
            inputTextFieldPhone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputTextFieldPhone.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            inputTextFieldBussinessType.topAnchor.constraint(equalTo: inputTextFieldPhone.bottomAnchor, constant: 30),
            inputTextFieldBussinessType.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputTextFieldBussinessType.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            inputSelectImageButton.topAnchor.constraint(equalTo: inputTextFieldBussinessType.bottomAnchor, constant: 30),
            inputSelectImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputSelectImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            addBussinessButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addBussinessButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            addBussinessButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            addBussinessButton.heightAnchor.constraint(equalToConstant: 50),
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.widthAnchor.constraint(equalToConstant: 120),
            loadingView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
