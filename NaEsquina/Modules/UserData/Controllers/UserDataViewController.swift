//
//  UserDataViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 17/10/24.
//

import UIKit

class UserDataViewController: UIViewController {

    // MARK: - UI Components

    var coordinator: UserDataCoordinator?

    // MARK: - UI Components

    private lazy var backButton: UIButton = .createCustomBackButton(target: self, action: #selector(backButtonTapped),
                                                                    borderColor: ColorsExtension.lightGray ?? .black)

    private lazy var currentViewDescriptionView: CurrentViewDescriptionView = {
        let view = CurrentViewDescriptionView(viewTitle: "Dados da conta",
                                              viewDescription: "Minhas informações da conta.")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var userWithDescriptionView: InputTextFieldView = {
        let view = InputTextFieldView(descriptionText: "Nome",
                                            inputPlaceholder: "Gustavo Ferreira Dos Santos",
                                            icon: "person", leftView: true,
                                            horRotation: false,
                                            inputDisabled: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var emailWithDescriptionView: InputEmailView = {
        let view = InputEmailView(descriptionText: "Email",
                                            inputPlaceholder: "Seu email",
                                            inputDisabled: true)
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

    private lazy var resendUserDataButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        button.setTitle("Alterar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorsExtension.purpleMedium
        button.layer.cornerRadius = 9
        button.addTarget(self, action: #selector(resendUserData), for: .touchUpInside)
        button.layer.shadowColor = ColorsExtension.purpleLight?.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 0
        return button
    }()

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Actions

    @objc func backButtonTapped() {
        coordinator?.backToPreviousScreen()
    }

    @objc func resendUserData() {
        print("ACTION DE REENVIAR DADOS DO USUARIO")
    }
}

extension UserDataViewController: SetupView {
    func setup() {
        navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(backButton)
        view.addSubview(currentViewDescriptionView)
        view.addSubview(userWithDescriptionView)
        view.addSubview(emailWithDescriptionView)
        view.addSubview(passwordWithDescriptionView)
        view.addSubview(rePasswordWithDescriptionView)
        view.addSubview(resendUserDataButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),

            currentViewDescriptionView.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 30),
            currentViewDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            currentViewDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            userWithDescriptionView.topAnchor.constraint(equalTo: self.currentViewDescriptionView.bottomAnchor, constant: 100),
            userWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            userWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            emailWithDescriptionView.topAnchor.constraint(equalTo: self.userWithDescriptionView.bottomAnchor, constant: 30),
            emailWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            passwordWithDescriptionView.topAnchor.constraint(equalTo: self.emailWithDescriptionView.bottomAnchor, constant: 30),
            passwordWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            rePasswordWithDescriptionView.topAnchor.constraint(equalTo: self.passwordWithDescriptionView.bottomAnchor, constant: 30),
            rePasswordWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            rePasswordWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            resendUserDataButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            resendUserDataButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            resendUserDataButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            resendUserDataButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            resendUserDataButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
