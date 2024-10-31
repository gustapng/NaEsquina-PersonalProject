//
//  LoginViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 03/09/24.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    // MARK: Variables

    var auth: Auth?

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
        button.addTarget(self, action: #selector(goToMainMenuView), for: .touchUpInside)
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

    @objc private func goToRecoverView() {
        let recoveryViewController = RecoveryViewController()
        navigationController?.pushViewController(recoveryViewController, animated: true)
    }

    @objc private func goToRegisterView() {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }

    @objc private func goToMainMenuView() {
        // TODO: - Lógica de login
        let email: String = emailWithDescriptionView.getInputText() ?? ""
        let password: String = passwordWithDescriptionView.getInputText() ?? ""

        self.auth?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print("Dados incorretos, tente novamente")
            } else {
                if user == nil {
                    print("Tivemos um problema inesperado")
                } else {
                    print("Login feito com sucesso!")
                }
            }
        })
//        let mapViewController = MapViewController()
//        navigationController?.pushViewController(mapViewController, animated: true)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
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