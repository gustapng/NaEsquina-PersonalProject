//
//  OtpViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 22/09/24.
//

import UIKit

class OtpViewController: UIViewController {

    // MARK: UI Components

    private lazy var backButton: UIButton = {
        return UIButton.createCustomBackButton(target: self, action: #selector(backButtonTapped), borderColor: ColorsExtension.lightGray ?? .black)
    }()

    private lazy var imageWithDescription: ImageWithInfoView = {
        let view = ImageWithInfoView(image: Constants.OtpVerification.image, mainMessage: Constants.OtpVerification.mainMessage, description: Constants.OtpVerification.description)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var emailInputWithDescriptionView: InputWithDescriptionView = {
        let view = InputWithDescriptionView(descriptionText: "Código de verificação", inputPlaceholder: "Seu email", isPassword: false, icon: "envelope", leftView: true, horRotation: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var optCodeView: OtpTextFieldView = {
        let view = OtpTextFieldView(descriptionText: "Código de verificação")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var sendCodeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        button.setTitle("Verificar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorsExtension.purpleMedium
        button.layer.cornerRadius = 9
        button.addTarget(self, action: #selector(goToNewPasswordView), for: .touchUpInside)
        button.layer.shadowColor = ColorsExtension.purpleLight?.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 0
        return button
    }()

    private lazy var resendCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Não recebeu o código?"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()

    private lazy var resendCodeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(ColorsExtension.purpleMedium, for: .normal)
        button.addTarget(self, action: #selector(resendCode), for: .touchUpInside)

        let attributedString = NSMutableAttributedString(string: "Reenviar")
         attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))

        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()

    // MARK: Functions

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc private func goToNewPasswordView() {
        // CRIAR VIEW CONTROLLER DE NOVA SENHA
    }

    @objc private func resendCode() {
        // Lógica para reenviar código de recuperação para o email
        print("Reenviar código")
    }

    // MARK: Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension OtpViewController: SetupView {
    func setup() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(backButton)
        view.addSubview(imageWithDescription)
        view.addSubview(optCodeView)
        view.addSubview(sendCodeButton)
        view.addSubview(resendCodeLabel)
        view.addSubview(resendCodeButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),

            imageWithDescription.heightAnchor.constraint(equalToConstant: 380),
            imageWithDescription.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            imageWithDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            imageWithDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            optCodeView.topAnchor.constraint(equalTo: imageWithDescription.bottomAnchor, constant: 58),
            optCodeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            optCodeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            sendCodeButton.topAnchor.constraint(equalTo: optCodeView.bottomAnchor, constant: 38),
            sendCodeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sendCodeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            sendCodeButton.heightAnchor.constraint(equalToConstant: 45),
            
            resendCodeLabel.topAnchor.constraint(equalTo: sendCodeButton.bottomAnchor, constant: 30),
            resendCodeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            resendCodeButton.topAnchor.constraint(equalTo: resendCodeLabel.bottomAnchor, constant: -2),
            resendCodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
