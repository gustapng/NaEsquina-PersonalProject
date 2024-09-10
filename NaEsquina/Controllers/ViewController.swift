//
//  ViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 03/09/24.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: UI Components
    
    private lazy var currentViewDescriptionView: CurrentViewDescriptionView = {
        let view = CurrentViewDescriptionView(ViewTitle: "Login", ViewDescription: "Faça login para continuar usando o aplicativo")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emailInputWithDescriptionView: InputWithDescriptionView = {
        let view = InputWithDescriptionView(descriptionText: "Email", inputLabelPlaceholder: "Seu email", isPassword: false, iconName: "envelope", iconSize: CGSize(width: 20, height: 20), isLeftView: true, horizontalRotation: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var passwordInputWithDescriptionView: InputPasswordView = {
        let view = InputPasswordView(descriptionText: "Senha", inputLabelPlaceholder: "Sua senha", iconSize: CGSize(width: 20, height: 20))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var recoverPassword: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.setTitleColor(ColorsExtension.purpleMedium, for: .normal)
        button.addTarget(self, action: #selector(goToRecoverView), for: .touchUpInside)
        
        let attributedString = NSMutableAttributedString(string: "Esqueceu sua senha?")
         attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()
    
    private lazy var registerAccount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Não possuí conta?"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private lazy var registerAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.setTitleColor(ColorsExtension.purpleMedium, for: .normal)
        button.addTarget(self, action: #selector(goToRegisterView), for: .touchUpInside)
        
        let attributedString = NSMutableAttributedString(string: "Registre-se")
         attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        
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
        return button
    }()
    
    //MARK: Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: Functions
    
    @objc private func goToRecoverView() {
        let recoveryViewController = RecoveryViewController()
        navigationController?.pushViewController(recoveryViewController, animated: true)
    }
    
    @objc private func goToRegisterView() {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    @objc private func goToMainMenuView() {
        let mainMenuViewController = mainMenuViewController()
        navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
}

extension ViewController: SetupView {
    func setup() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(currentViewDescriptionView)
        view.addSubview(emailInputWithDescriptionView)
        view.addSubview(passwordInputWithDescriptionView)
        view.addSubview(recoverPassword)
        view.addSubview(loginButton)
        view.addSubview(registerAccount)
        view.addSubview(registerAccountButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            currentViewDescriptionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),

            emailInputWithDescriptionView.topAnchor.constraint(equalTo: currentViewDescriptionView.bottomAnchor, constant: 146),
            emailInputWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailInputWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            passwordInputWithDescriptionView.topAnchor.constraint(equalTo: emailInputWithDescriptionView.bottomAnchor, constant: 18),
            passwordInputWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordInputWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            recoverPassword.topAnchor.constraint(equalTo: passwordInputWithDescriptionView.bottomAnchor, constant: 12),
            recoverPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            loginButton.topAnchor.constraint(equalTo: recoverPassword.bottomAnchor, constant: 84),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            loginButton.heightAnchor.constraint(equalToConstant: 45),

            registerAccount.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 84),
            registerAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            registerAccountButton.topAnchor.constraint(equalTo: registerAccount.bottomAnchor, constant: -2),
            registerAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
