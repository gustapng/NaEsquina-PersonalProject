//
//  RecoveryViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 08/09/24.
//

import UIKit

class RecoveryViewController: UIViewController {

    // MARK: UI Components

    private lazy var backButton: UIButton = {
        return UIButton.createCustomBackButton(target: self, action: #selector(backButtonTapped), borderColor: ColorsExtension.lightGray ?? .black)
    }()

    private lazy var imageWithDescription: ImageWithInfoView = {
        let view = ImageWithInfoView(image: Constants.PasswordRecovery.imageDetails, mainMessage: Constants.PasswordRecovery.mainMessage, description: Constants.PasswordRecovery.description)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emailInputWithDescriptionView: InputWithDescriptionView = {
        let view = InputWithDescriptionView(descriptionText: "Email", inputPlaceholder: "Seu email", isPassword: false, icon: "envelope", leftView: true, horRotation: false)
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
        button.addTarget(self, action: #selector(goToOtpView), for: .touchUpInside)
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
    
    @objc private func goToOtpView() {
        let otpViewController = OtpViewController()
        navigationController?.pushViewController(otpViewController, animated: true)
    }

    // MARK: Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension RecoveryViewController: SetupView {
    func setup() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(backButton)
        view.addSubview(imageWithDescription)
        view.addSubview(emailInputWithDescriptionView)
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

            emailInputWithDescriptionView.topAnchor.constraint(equalTo: imageWithDescription.bottomAnchor, constant: 58),
            emailInputWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailInputWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            sendCodeButton.topAnchor.constraint(equalTo: emailInputWithDescriptionView.bottomAnchor, constant: 33.5),
            sendCodeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sendCodeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            sendCodeButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}
