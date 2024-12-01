//
//  AddBusinessViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 18/09/24.
//

import UIKit
import MapKit		

class AddBusinessViewController: UIViewController {

    // MARK: - Attributes

    var selectedCoordinate: CLLocationCoordinate2D?
    weak var delegate: RemovePinDelegate?

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
        // TODO: CREATE ACTION FOR THIS BUTTON
        button.addTarget(self, action: #selector(saveBusinessData), for: .touchUpInside)
        button.layer.shadowColor = ColorsExtension.purpleLight?.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 0
        return button
    }()

    // MARK: - Function

    @objc func saveBusinessData() {
        let name = inputTextFieldName.getValue() ?? ""
        let phone = inputTextFieldPhone.getValue() ?? ""
        let option = inputTextFieldBussinessType.getValue() ?? ""
        print(name)
        print(phone)
        print(option)
    }

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.removeTemporaryPin()
    }
}

extension AddBusinessViewController: SetupView {
    func setup() {
        view.backgroundColor = .white
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
            addBussinessButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
