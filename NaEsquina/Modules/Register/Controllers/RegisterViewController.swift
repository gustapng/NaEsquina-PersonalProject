//
//  RegisterViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 09/09/24.
//

import UIKit
import Firebase
import FirebaseAuth
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {

    // MARK: - Coordinators

    var coordinator: RegisterCoordinator?

    // MARK: - Variables

    var auth: Auth?
    private let loadingSubject = BehaviorSubject<Bool>(value: false)
    private let disposeBag = DisposeBag()

    // MARK: - UI Components

    private lazy var backButton: UIButton = .createCustomBackButton(target: self, action: #selector(backButtonTapped),
                                                                    borderColor: ColorsExtension.lightGray ?? .black)

    private lazy var currentViewDescriptionView: CurrentViewDescriptionView = {
        let view = CurrentViewDescriptionView(viewTitle: "Registre se",
                                              viewDescription: "Crie sua conta para começar a descobrir e interagir com comércios locais.")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var usernameWithDescriptionView: InputTextFieldView = {
        let view = InputTextFieldView(descriptionText: "Nome de usuário",
                                            inputPlaceholder: "Seu nome",
                                            icon: "person",
                                            leftView: true,
                                            horRotation: false,
                                            inputDisabled: false)
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
        let view = InputPasswordView(descriptionText: "Senha",
                                     inputLabelPlaceholder: "Sua senha")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var rePasswordWithDescriptionView: InputPasswordView = {
        let view = InputPasswordView(descriptionText: "Confirmar senha",
                                     inputLabelPlaceholder: "Confirme sua senha")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        button.setTitle("Registrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorsExtension.purpleMedium
        button.layer.cornerRadius = 9
        button.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
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

    // MARK: Functions

    @objc func backButtonTapped() {
        coordinator?.backToPreviousScreen()
    }

    @objc private func dismissKeyboard() {
       view.endEditing(true)
    }

    private func validateRegisterFields() -> (isValid: Bool, errorMessage: String?) {
        let username = usernameWithDescriptionView.getInputText() ?? ""
        let email = emailWithDescriptionView.getInputText() ?? ""
        let password = passwordWithDescriptionView.getInputText() ?? ""
        let rePassword = rePasswordWithDescriptionView.getInputText() ?? ""

        guard !username.isEmpty, !email.isEmpty, !password.isEmpty, !rePassword.isEmpty else {
            return (false, "Por favor, preencha todos os campos.")
        }

        if !isValidPassword(password) {
            return (false, "A senha deve ter pelo menos 8 caracteres, incluindo uma letra maiúscula, uma letra minúscula, um número e um caractere especial.")
        }

        if password != rePassword {
            return (false, "As senhas inseridas são diferentes.")
        }

        return (true, nil)
    }

    @objc func registerUser() {
        let validation = validateRegisterFields()
        guard validation.isValid else {
            showAlert(on: self, title: "Atenção", message: validation.errorMessage!)
            return
        }

        guard let email = emailWithDescriptionView.getInputText(),
              let password = passwordWithDescriptionView.getInputText(),
              let username = usernameWithDescriptionView.getInputText() else {
            return
        }

        // TODO: Maybe review the user creation and data insertion logic

        loadingSubject.onNext(true)

        auth?.rx.createUser(withEmail: email, password: password)
            .flatMap { authResult in
                return self.auth?.rx.saveUserData(username: username, email: email) ?? .just(())
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] _ in
                guard let self = self else { return }

                self.loadingSubject.onNext(false)

                auth?.currentUser?.sendEmailVerification(completion: { error in
                    if let error = error {
                        showAlert(on: self, title: "Erro", message: "Erro ao enviar email de verificação: \(error.localizedDescription)")
                    }
                })

                let successMessage = "Cadastro realizado com sucesso!\nPara concluir e liberar o acesso à sua conta, confirme o cadastro acessando o link enviado para o seu email."
                showAlert(on: self, title: "Sucesso", message: successMessage) {
                    self.navigationController?.popViewController(animated: true)
                }
            }, onFailure: { [weak self] error in
                guard let self = self else { return }

                self.loadingSubject.onNext(false)
                self.handleFirebaseRegisterError(error)
            })
            .disposed(by: disposeBag)
    }

    private func handleFirebaseRegisterError(_ error: Error) {
        let authError = error as NSError
        var message = "Falha ao cadastrar"

        if let errCode = AuthErrorCode(rawValue: authError.code) {
            switch errCode {
            case .emailAlreadyInUse:
                message = "Este email já está em uso."
            case .invalidEmail:
                message = "O email informado não é válido."
            case .weakPassword:
                message = "A senha é muito fraca."
            default:
                message = "Erro desconhecido: \(authError.localizedDescription)"
            }
        }

        showAlert(on: self, title: "Erro", message: message)
    }

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension RegisterViewController: SetupView {
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
        view.addSubview(currentViewDescriptionView)
        view.addSubview(usernameWithDescriptionView)
        view.addSubview(emailWithDescriptionView)
        view.addSubview(passwordWithDescriptionView)
        view.addSubview(rePasswordWithDescriptionView)
        view.addSubview(registerButton)
        view.addSubview(loadingView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),

            currentViewDescriptionView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            currentViewDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            currentViewDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            usernameWithDescriptionView.topAnchor.constraint(equalTo: currentViewDescriptionView.bottomAnchor, constant: 110),
            usernameWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            usernameWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            emailWithDescriptionView.topAnchor.constraint(equalTo: usernameWithDescriptionView.bottomAnchor, constant: 30),
            emailWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            passwordWithDescriptionView.topAnchor.constraint(equalTo: emailWithDescriptionView.bottomAnchor, constant: 30),
            passwordWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            rePasswordWithDescriptionView.topAnchor.constraint(equalTo: passwordWithDescriptionView.bottomAnchor, constant: 30),
            rePasswordWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            rePasswordWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            registerButton.topAnchor.constraint(equalTo: rePasswordWithDescriptionView.bottomAnchor, constant: 50),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            registerButton.heightAnchor.constraint(equalToConstant: 45),

            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.widthAnchor.constraint(equalToConstant: 120),
            loadingView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
