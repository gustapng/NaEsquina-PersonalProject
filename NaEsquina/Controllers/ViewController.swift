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
    
    private lazy var passwordInputWithDescriptionView: InputWithDescriptionView = {
        let view = InputWithDescriptionView(descriptionText: "Senha", inputLabelPlaceholder: "Sua senha", isPassword: true, iconName: "key.horizontal", iconSize: CGSize(width: 20, height: 20), isLeftView: true, horizontalRotation: true)
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
    
    //MARK: Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: Functions
    
    @objc private func goToRecoverView() {
        let recoveryViewController = RecoveryViewController()
        // Navega para a próxima tela
        navigationController?.pushViewController(recoveryViewController, animated: true)
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
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            currentViewDescriptionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),

            emailInputWithDescriptionView.topAnchor.constraint(equalTo: currentViewDescriptionView.bottomAnchor, constant: 124),
            emailInputWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailInputWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            passwordInputWithDescriptionView.topAnchor.constraint(equalTo: emailInputWithDescriptionView.bottomAnchor, constant: 18),
            passwordInputWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordInputWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            recoverPassword.topAnchor.constraint(equalTo: passwordInputWithDescriptionView.bottomAnchor, constant: 12),
            recoverPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

        ])
    }
}
