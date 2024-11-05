//
//  RecoveryViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 08/09/24.
//

import UIKit
import FirebaseAuth

class RecoveryViewController: UIViewController {
    
    // MARK: Variables

    var auth: Auth?

    // MARK: UI Components

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

    // MARK: Functions

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    private func validateRecoveryFields() -> (isValid: Bool, errorMessage: String?) {
        let email = emailWithDescriptionView.getInputText() ?? ""

        guard !email.isEmpty else {
            return (false, "\nPor favor, preencha o campo de email.")
        }

        return (true, nil)
    }

    @objc private func sendPasswordReset() {
        let validation = validateRecoveryFields()
        guard validation.isValid else {
            showAlert(on: self, title: "Atenção", message: validation.errorMessage!)
            return
        }

        guard let email = emailWithDescriptionView.getInputText() else {
            return
        }

        self.auth?.sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.handleFirebasePasswordResetError(error)
                return
            }

            let successMessage = "Um email com instruções para redefinir sua senha foi enviado para o endereço fornecido.\nVerifique sua caixa de entrada e siga as instruções para recuperar o acesso à sua conta."

            showAlert(on: self, title: "Email de recuperação enviado", message: successMessage) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    private func handleFirebasePasswordResetError(_ error: Error) {
        let authError = error as NSError
        var message = "Falha ao enviar email de recuperação de senha."

        if let errCode = AuthErrorCode(rawValue: authError.code) {
            switch errCode {
            case .invalidEmail:
                message = "O formato do email fornecido é inválido."
            case .invalidRecipientEmail:
                message = "O endereço de email fornecido não é válido."
            case .userNotFound:
                message = "Não existe um usuário cadastrado com o endereço de email fornecido."
            default:
                message = "Erro desconhecido: \(authError.localizedDescription)"
            }
        }

        showAlert(on: self, title: "Erro", message: message)
    }

    // MARK: Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        self.auth = Auth.auth()
        setup()
    }
}

extension RecoveryViewController: SetupView {
    func setup() {
        navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(backButton)
        view.addSubview(imageWithDescription)
        view.addSubview(emailWithDescriptionView)
        view.addSubview(sendCodeButton)
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
            sendCodeButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
