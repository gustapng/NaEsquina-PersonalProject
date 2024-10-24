//
//  registerViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 09/09/24.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: UI Components

    private lazy var backButton: UIButton = {
        return UIButton.createCustomBackButton(target: self, action: #selector(backButtonTapped), borderColor: ColorsExtension.lightGray ?? .black)
    }()

    private lazy var currentViewDescriptionView: CurrentViewDescriptionView = {
        let view = CurrentViewDescriptionView(viewTitle: "Registre se", viewDescription: "Crie sua conta para começar a descobrir e interagir com comércios locais.")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var userInputWithDescriptionView: InputWithDescriptionView = {
        let view = InputWithDescriptionView(descriptionText: "Nome de usuário", inputPlaceholder: "Seu nome", icon: "person", leftView: true, horRotation: false, inputDisabled: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var emailInputWithDescriptionView: InputWithDescriptionView = {
        let view = InputWithDescriptionView(descriptionText: "Email", inputPlaceholder: "Seu email", icon: "envelope", leftView: true, horRotation: false, inputDisabled: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var passwordInputWithDescriptionView: InputPasswordView = {
        let view = InputPasswordView(descriptionText: "Senha", inputLabelPlaceholder: "Sua senha")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var rePasswordInputWithDescriptionView: InputPasswordView = {
        let view = InputPasswordView(descriptionText: "Confirmar senha", inputLabelPlaceholder: "Confirme sua senha")
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
        button.addTarget(self, action: #selector(goToConfirmEmailViewController), for: .touchUpInside)
        button.layer.shadowColor = ColorsExtension.purpleLight?.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 0
        return button
    }()

    // MARK: Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: Functions

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func goToConfirmEmailViewController() {
        let confirmEmailViewController = ConfirmEmailViewController()
        navigationController?.pushViewController(confirmEmailViewController, animated: true)
    }
}

extension RegisterViewController: SetupView {
    func setup() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(backButton)
        view.addSubview(currentViewDescriptionView)
        view.addSubview(userInputWithDescriptionView)
        view.addSubview(emailInputWithDescriptionView)
        view.addSubview(passwordInputWithDescriptionView)
        view.addSubview(rePasswordInputWithDescriptionView)
        view.addSubview(registerButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),

            currentViewDescriptionView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            currentViewDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            currentViewDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            userInputWithDescriptionView.topAnchor.constraint(equalTo: currentViewDescriptionView.bottomAnchor, constant: 110),
            userInputWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            userInputWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            emailInputWithDescriptionView.topAnchor.constraint(equalTo: userInputWithDescriptionView.bottomAnchor, constant: 30),
            emailInputWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailInputWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            passwordInputWithDescriptionView.topAnchor.constraint(equalTo: emailInputWithDescriptionView.bottomAnchor, constant: 30),
            passwordInputWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordInputWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            rePasswordInputWithDescriptionView.topAnchor.constraint(equalTo: passwordInputWithDescriptionView.bottomAnchor, constant: 30),
            rePasswordInputWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            rePasswordInputWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            registerButton.topAnchor.constraint(equalTo: rePasswordInputWithDescriptionView.bottomAnchor, constant: 50),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            registerButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}
