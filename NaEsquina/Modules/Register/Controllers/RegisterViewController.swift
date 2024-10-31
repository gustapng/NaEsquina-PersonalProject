//
//  RegisterViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 09/09/24.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {

    // MARK: Variables

    var auth: Auth?
    var db: FirebaseService?

    // MARK: UI Components

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
        self.auth = Auth.auth()
        setup()
    }

    // MARK: Functions

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func alert(title: String, message: String) {
        let alertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok:UIAlertAction = UIAlertAction(title: "Ok", style: .cancel)
        
        alertController.addAction(ok)
        self.present(alertController, animated: true)
    }
    
    @objc private func dismissKeyboard() {
       view.endEditing(true) // Fecha o teclado
    }

    @objc func goToConfirmEmailViewController() {
        
        let username: String = usernameWithDescriptionView.getInputText() ?? ""
        let email: String = emailWithDescriptionView.getInputText() ?? ""
        let password: String = passwordWithDescriptionView.getInputText() ?? ""
        let rePassword: String = rePasswordWithDescriptionView.getInputText() ?? ""
        
        if username.isEmpty || email.isEmpty || password.isEmpty || rePassword.isEmpty {
            alert(title: "Atenção", message: "Por favor, preencha todos os campos.")
            return
        }
        
        if !isValidPassword(password) {
            alert(title: "Atenção", message: "Para garantir a segurança da sua conta, sua senha precisa atender a alguns critérios.\n\nLembre-se:\n\nEla deve ter pelo menos 8 caracteres.\nInclua pelo menos uma letra maiúscula, uma letra minúscula, um número e um caractere especial.")
            return
        }
        
        if rePassword != password {
            alert(title: "Erro", message: "As senhas inseridas são diferentes.\nCertifique-se de que ambas as senhas sejam idênticas.")
            return
        }

        self.auth?.createUser(withEmail: email, password: password, completion: { (result, error) in
            if error != nil {
                self.alert(title: "Atenção", message: "Falha ao cadastrar")
                print("Erro ao cadastrar")
            } else {
                
                let userData: [String: Any] = [
                  "email": email,
                  "username": username
                ]

                FirebaseService.shared.db.collection("data").document("one").setData(userData)
                print("Document successfully written!")
                
                self.alert(title: "Parabéns", message: "Sucesso ao cadastrar")
                print("Sucesso ao cadastrar")
            }
        })
//        let confirmEmailViewController = ConfirmEmailViewController()
//        navigationController?.pushViewController(confirmEmailViewController, animated: true)
    }
}

extension RegisterViewController: SetupView {
    func setup() {
        navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
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
            registerButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
