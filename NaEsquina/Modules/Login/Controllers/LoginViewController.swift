//
//  LoginViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 03/09/24.
//

import UIKit
import Firebase
import FirebaseAuth
import LocalAuthentication
import CoreData

class LoginViewController: UIViewController {

    // MARK: Attributes

    var auth: Auth?
    var context = CoreDataManager.shared.context

    // MARK: UI Components

    private lazy var currentViewDescriptionView: CurrentViewDescriptionView = {
        let view = CurrentViewDescriptionView(viewTitle: "Login",
                                              viewDescription: """
                                                Acesse sua conta para explorar comércios e 
                                                serviços locais de forma rápida e segura.
                                                """.trimmingCharacters(in: .whitespacesAndNewlines))
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

    private lazy var passwordWithDescriptionView: InputPasswordView = {
        let view = InputPasswordView(descriptionText: "Senha", inputLabelPlaceholder: "Sua senha")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var recoverPassword: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.setTitleColor(ColorsExtension.purpleMedium, for: .normal)
        button.addTarget(self, action: #selector(self.goToRecoverView), for: .touchUpInside)

        let attributedString = NSMutableAttributedString(string: "Esqueceu sua senha?")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: attributedString.length))

        button.setAttributedTitle(attributedString, for: .normal)
        return button	
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorsExtension.purpleMedium
        button.layer.cornerRadius = 9
        button.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        button.layer.shadowColor = ColorsExtension.purpleLight?.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 0
        return button
    }()

    private lazy var registerAccount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Não possuí conta?"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()

    private lazy var registerAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(ColorsExtension.purpleMedium, for: .normal)
        button.addTarget(self, action: #selector(goToRegisterView), for: .touchUpInside)

        let attributedString = NSMutableAttributedString(string: "Registre-se")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: attributedString.length))

        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()

    // MARK: Functions

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func goToRecoverView() {
        let recoveryViewController = RecoveryViewController()
        navigationController?.pushViewController(recoveryViewController, animated: true)
    }

    @objc private func goToRegisterView() {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }

    private func validateLoginFields() -> (isValid: Bool, errorMessage: String?) {
        let email = emailWithDescriptionView.getInputText() ?? ""
        let password = passwordWithDescriptionView.getInputText() ?? ""

        guard !email.isEmpty, !password.isEmpty else {
            return (false, "Por favor, preencha todos os campos.")
        }

        if !isValidPassword(password) {
            return (false, "A senha deve ter pelo menos 8 caracteres, incluindo uma letra maiúscula, uma letra minúscula, um número e um caractere especial.")
        }

        return (true, nil)
    }

    @objc private func loginUser() {
        let validation = validateLoginFields()
        guard validation.isValid else {
            showAlert(on: self, title: "Atenção", message: validation.errorMessage!)
            return
        }

        guard let email = emailWithDescriptionView.getInputText(),
              let password = passwordWithDescriptionView.getInputText() else {
            return
        }

        self.auth?.signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            guard let self = self else { return }

            if let error = error {
                handleFirebaseLoginError(error)
                return
            }

            guard let user = authResult?.user else {
                showAlert(on: self, title: "Erro", message: "Tivemos um problema inesperado, tente novamente.")
                return
            }

            if user.isEmailVerified {
                self.navigateToMapView()
                askToEnableFaceID()
            } else {
                self.handleUnverifiedEmail(for: user)
            }
        })
    }

    private func getUserSettings() -> UserSettings? {
        let fetchRequest: NSFetchRequest<UserSettings> = UserSettings.fetchRequest()

        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            if fetchedObjects.isEmpty {
                return nil
            }

            return fetchedObjects.last
        } catch {
            print("Erro ao buscar UserSettings: \(error.localizedDescription)")
            return nil
        }
    }

    private func navigateToMapView(_ delay: Bool = false) {
        let mapViewController = MapViewController()
        navigationController?.pushViewController(mapViewController, animated: true)

        if (delay) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if let lastLogin = self.getUserSettings(), !lastLogin.isFaceIDEnabled {
                    mapViewController.showWelcomeMessage()
                }
            }
        }
    }

    private func handleUnverifiedEmail(for user: User) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError {
            print("Erro ao fazer signOut: \(signOutError)")
        }

        user.sendEmailVerification { [weak self] error in
            guard let self = self else { return }
            let authError = error as NSError?

            if let error = error {
                if authError?.code == 17010 {
                    showAlert(on: self, title: "Erro", message: "Houve um problema ao tentar reenviar o e-mail de autenticação. Por favor, tente novamente em alguns minutos.")
                } else {
                    showAlert(on: self, title: "Erro", message: "Erro ao enviar email de verificação: \(error.localizedDescription)")
                }
            } else {
                showAlert(on: self, title: "Verificação de E-mail Necessária", message: "Um novo email de autenticação foi enviado para seu email, por favor verifique seu e-mail para completar o login.")
            }
        }
    }

    private func handleFirebaseLoginError(_ error: Error) {
        let authError = error as NSError
        var message = "Falha ao logar"

        if let errCode = AuthErrorCode(rawValue: authError.code) {
            switch errCode {
            case .invalidEmail:
                message = "O email informado não é válido."
            case .invalidCredential:
                message = "Email ou senha não conferem, tente novamente."
            default:
                message = "Erro desconhecido: \(authError.localizedDescription)"
            }
        }

        showAlert(on: self, title: "Erro", message: message)
    }

    private func showWelcomeMessage() {
        let alertController = UIAlertController(title: "Bem-vindo!", message: "Login realizado com sucesso!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)

        if let mapVC = self.navigationController?.topViewController as? MapViewController {
            mapVC.present(alertController, animated: true, completion: nil)
        }
    }

    private func authenticateUserWithFaceID() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Autentique-se para acessar seu aplicativo"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.navigateToMapView(true)
                    } else {
                        if let error = authenticationError {
                            showAlert(on: self, title: "Erro", message: error.localizedDescription)
                        }
                    }
                }
            }
        } else {
            showAlert(on: self,title: "Erro", message: "Face ID não está disponível neste dispositivo.")
        }
    }

    private func askToEnableFaceID() {
        let alertController = UIAlertController(title: "Habilitar Face ID", message: "Você gostaria de habilitar o login com Face ID para futuras sessões?", preferredStyle: .alert)

        let enableAction = UIAlertAction(title: "Habilitar", style: .default) { _ in
            let fetchRequest: NSFetchRequest<UserSettings> = UserSettings.fetchRequest()

            do {
                let fetchedObjects = try self.context.fetch(fetchRequest)
                let userSettings = fetchedObjects.last ?? UserSettings(context: self.context)
                
                userSettings.isFaceIDEnabled = true
                userSettings.loggedDate = Date()

                try self.context.save()
            } catch {
                print("Erro ao salvar UserSettings: \(error.localizedDescription)")
            }
        }

        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(enableAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    // MARK: Initializers

    override func viewDidLoad() {
        super.viewDidLoad()

        if let lastLogin = getUserSettings(), lastLogin.isFaceIDEnabled {
            authenticateUserWithFaceID()
        }

        self.auth = Auth.auth()
        setup()
    }
}

extension LoginViewController: SetupView {
    func setup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.backgroundColor = .white
        view.addGestureRecognizer(tap)
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(currentViewDescriptionView)
        view.addSubview(emailWithDescriptionView)
        view.addSubview(passwordWithDescriptionView)
        view.addSubview(recoverPassword)
        view.addSubview(loginButton)
        view.addSubview(registerAccount)
        view.addSubview(registerAccountButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            currentViewDescriptionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 68),
            currentViewDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            currentViewDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            emailWithDescriptionView.topAnchor.constraint(equalTo: currentViewDescriptionView.bottomAnchor, constant: 146),
            emailWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            passwordWithDescriptionView.topAnchor.constraint(equalTo: emailWithDescriptionView.bottomAnchor, constant: 18),
            passwordWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            recoverPassword.topAnchor.constraint(equalTo: passwordWithDescriptionView.bottomAnchor, constant: 12),
            recoverPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            loginButton.topAnchor.constraint(equalTo: recoverPassword.bottomAnchor, constant: 84),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            loginButton.heightAnchor.constraint(equalToConstant: 50),

            registerAccount.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 84),
            registerAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            registerAccountButton.topAnchor.constraint(equalTo: registerAccount.bottomAnchor, constant: -2),
            registerAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
