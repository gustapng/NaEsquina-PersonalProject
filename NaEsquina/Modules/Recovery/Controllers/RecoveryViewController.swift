//
//  RecoveryViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 08/09/24.
//

import UIKit
import FirebaseAuth
import RxSwift
import RxCocoa

class RecoveryViewController: UIViewController {

    // MARK: - Coordinator

    var coordinator: CoordinatorFlowController?

    // MARK: - Attributes

    var auth: Auth?
    private let loadingSubject = BehaviorSubject<Bool>(value: false)
    private let disposeBag = DisposeBag()

    // MARK: - UI Components

    private lazy var backButton: UIButton = .createCustomBackButton(target: self, action: #selector(backButtonTapped),
                                                                    borderColor: ColorsExtension.lightGray ?? .black)

    private lazy var imageWithDescription: ImageWithInfoView = {
        let view = ImageWithInfoView(image: Constants.PasswordRecovery.imageDetails,
                                     mainMessage: Constants.PasswordRecovery.mainMessage,
                                     description: Constants.PasswordRecovery.description)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var emailWithDescriptionView: InputEmailView = {
        let view = InputEmailView(descriptionText: "Email",
                                  inputPlaceholder: "Seu email",
                                  inputDisabled: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var sendCodeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        button.setTitle("Enviar código", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorsExtension.purpleMedium
        button.layer.cornerRadius = 9
        button.addTarget(self, action: #selector(sendPasswordReset), for: .touchUpInside)
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

    @objc func backButtonTapped() {
        coordinator?.backToPreviousScreen()
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func validateRecoveryFields() -> (isValid: Bool, errorMessage: String?) {
        let email = emailWithDescriptionView.getValue() ?? ""

        guard !email.isEmpty else {
            return (false, "Por favor, preencha o campo de email.")
        }

        return (true, nil)
    }

    @objc private func sendPasswordReset() {
        let validation = validateRecoveryFields()
        guard validation.isValid else {
            showAlert(on: self, title: "Atenção", message: validation.errorMessage!)
            return
        }

        guard let email = emailWithDescriptionView.getValue() else { return }

        self.loadingSubject.onNext(true)

        auth?.rx.sendPasswordReset(withEmail: email)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] _ in
                guard let self = self else { return }
                self.loadingSubject.onNext(false)
                self.showSuccessMessage()
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                self.loadingSubject.onNext(false)
                self.handleFirebasePasswordResetError(error)
            })
            .disposed(by: disposeBag)
    }

    private func showSuccessMessage() {
        let successMessage = "Um email com instruções para redefinir sua senha foi enviado para o endereço fornecido.\nVerifique sua caixa de entrada e siga as instruções para recuperar o acesso à sua conta."
        showAlert(on: self, title: "Email de recuperação enviado", message: successMessage) {
            self.navigationController?.popViewController(animated: true)
        }
    }

    private func handleFirebasePasswordResetError(_ error: Error) {
        let authError = error as NSError
        var message = "Falha ao enviar email de recuperação de senha."

        if let errCode = AuthErrorCode(rawValue: authError.code) {
            message = self.mapAuthErrorToMessage(errCode)
        }

        showAlert(on: self, title: "Erro", message: message)
    }

    private func mapAuthErrorToMessage(_ errorCode: AuthErrorCode) -> String {
        switch errorCode {
        case .invalidEmail:
            return "O formato do email fornecido é inválido."
        case .invalidRecipientEmail:
            return "O endereço de email fornecido não é válido."
        case .userNotFound:
            return "Não existe um usuário cadastrado com o endereço de email fornecido."
        default:
            return "Erro desconhecido."
        }
    }

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension RecoveryViewController: SetupView {
    func setup() {
        navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

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

        self.auth = Auth.auth()

        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(backButton)
        view.addSubview(imageWithDescription)
        view.addSubview(emailWithDescriptionView)
        view.addSubview(sendCodeButton)
        view.addSubview(loadingView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),

            imageWithDescription.heightAnchor.constraint(equalToConstant: 380),
            imageWithDescription.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            imageWithDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            imageWithDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            emailWithDescriptionView.topAnchor.constraint(equalTo: imageWithDescription.bottomAnchor, constant: 58),
            emailWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            sendCodeButton.topAnchor.constraint(equalTo: emailWithDescriptionView.bottomAnchor, constant: 33.5),
            sendCodeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sendCodeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            sendCodeButton.heightAnchor.constraint(equalToConstant: 45),

            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.widthAnchor.constraint(equalToConstant: 120),
            loadingView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
