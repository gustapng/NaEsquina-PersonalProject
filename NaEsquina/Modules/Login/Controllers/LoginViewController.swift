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
import SwiftKeychainWrapper
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    // MARK: - Coordinator

    var coordinator: CoordinatorFlowController?

    // MARK: Attributes

    var auth: Auth?
    var context = CoreDataManager.shared.context
    private let loadingSubject = BehaviorSubject<Bool>(value: false)
    private let disposeBag = DisposeBag()

    // MARK: - UI Components

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

    private lazy var recoveryPassword: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(ColorsExtension.purpleMedium, for: .normal)
        button.addTarget(self, action: #selector(self.navigateToRecoveryViewController), for: .touchUpInside)

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
        button.addTarget(self, action: #selector(navigateToRegisterViewController), for: .touchUpInside)

        let attributedString = NSMutableAttributedString(string: "Registre-se")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: attributedString.length))

        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()
    
    private lazy var loadingView: LoadingView = {
        let loading = LoadingView()
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()

    // MARK: - Functions

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func navigateToRecoveryViewController() {
        navigateToRecoveryView()
    }

    @objc private func navigateToRegisterViewController() {
        navigateToRegisterView()
    }

    @objc private func loginUser() {
        let email = emailWithDescriptionView.getValue() ?? ""
        let password = passwordWithDescriptionView.getValue() ?? ""
        let loginModel = LoginModel(email: email, password: password)

        if let errorMessage = loginModel.validationError {
            showAlert(on: self, title: "Atenção", message: errorMessage)
            return
        }
        
        loadingSubject.onNext(true)

        let firebaseAuthService = FirebaseAuthService(auth: Auth.auth())
        firebaseAuthService.login(email: email, password: password)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] authResult in
                guard let self = self else { return }

                self.loadingSubject.onNext(false)

                if authResult.user.isEmailVerified {
                    KeychainWrapper.standard.set(email, forKey: "userEmail")
                    KeychainWrapper.standard.set(password, forKey: "userPassword")

                    coordinator?.navigateToMenuView()
                    self.askToEnableFaceID()
                } else {
                    self.handleUnverifiedEmail(for: authResult.user)
                }
            }, onFailure: { [weak self] error in
                guard let self = self else { return }

                self.loadingSubject.onNext(false)
                self.handleFirebaseLoginError(error)
            })
            .disposed(by: disposeBag)
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

    private func handleUnverifiedEmail(for user: User) {
        loadingSubject.onNext(true)

        let firebaseAuthService = FirebaseAuthService(auth: Auth.auth())
        let result = firebaseAuthService.signOut()
            switch result {
            case .success:
                user.sendEmailVerification { [weak self] error in
                    guard let self = self else { return }
                    self.loadingSubject.onNext(false)

                    if let error = error {
                        let authError = error as NSError?
                        if authError?.code == 17010 {
                            showAlert(on: self, title: "Erro", message: "Houve um problema ao tentar reenviar o e-mail de autenticação. Por favor, tente novamente em alguns minutos.")
                        } else {
                            showAlert(on: self, title: "Erro", message: "Erro ao enviar email de verificação: \(error.localizedDescription)")
                        }
                    } else {
                        showAlert(on: self, title: "Verificação de\nE-mail Necessária", message: "Um novo email de autenticação foi enviado para seu email. Por favor, verifique seu e-mail para completar o login.")
                    }
                }
            case .failure(let error):
                loadingSubject.onNext(false)
                print("Erro ao fazer signOut: \(error.localizedDescription)")
                showAlert(on: self, title: "Erro", message: "Erro ao fazer logout: \(error.localizedDescription)")
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

    private func authenticateUserWithFaceID() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Autentique-se para acessar seu aplicativo"
            loadingSubject.onNext(true)

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    self.loadingSubject.onNext(false)
                    if success {
                        guard let email = KeychainWrapper.standard.string(forKey: "userEmail"),
                              let password = KeychainWrapper.standard.string(forKey: "userPassword") else {
                            print("Nenhuma credencial armazenada.")
                            return
                        }

                        self.auth?.signIn(withEmail: email, password: password) { result, error in
                            if let error = error {
                                print("Erro ao fazer login no Firebase: \(error.localizedDescription)")
                                return
                            }
                            print("Login via Face ID concluído com sucesso!")
                        }

                        self.navigateToMenuViewWithAlert()
                    } else {
                        if let error = authenticationError {
                            showAlert(on: self, title: "Erro", message: error.localizedDescription)
                        }
                    }
                }
            }
        } else {
            loadingSubject.onNext(false)
            showAlert(on: self, title: "Erro", message: "Face ID não está disponível neste dispositivo.")
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

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension LoginViewController: SetupView {
    func setup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.backgroundColor = .white
        view.addGestureRecognizer(tap)
        
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

        if let lastLogin = getUserSettings(), lastLogin.isFaceIDEnabled {
            authenticateUserWithFaceID()
        }

        self.auth = Auth.auth()
        
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(currentViewDescriptionView)
        view.addSubview(emailWithDescriptionView)
        view.addSubview(passwordWithDescriptionView)
        view.addSubview(recoveryPassword)
        view.addSubview(loginButton)
        view.addSubview(registerAccount)
        view.addSubview(registerAccountButton)
        view.addSubview(loadingView)
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

            recoveryPassword.topAnchor.constraint(equalTo: passwordWithDescriptionView.bottomAnchor, constant: 12),
            recoveryPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            loginButton.topAnchor.constraint(equalTo: recoveryPassword.bottomAnchor, constant: 84),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            loginButton.heightAnchor.constraint(equalToConstant: 50),

            registerAccount.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 84),
            registerAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            registerAccountButton.topAnchor.constraint(equalTo: registerAccount.bottomAnchor, constant: -2),
            registerAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.widthAnchor.constraint(equalToConstant: 120),
            loadingView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}

extension LoginViewController: LoginCoordinator {
    func navigateToRecoveryView() {
        coordinator?.navigateToRecoveryView()
    }
    
    func navigateToRegisterView() {
        coordinator?.navigateToRegisterView()
    }
    
    func navigateToMenuView() {
        coordinator?.navigateToMenuView()
    }
    
    func navigateToMenuViewWithAlert() {
        coordinator?.navigateToMenuViewWithAlert()
    }
}
