//
//  LabelButton.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 05/09/24.
//

import UIKit

class OtpTextFieldView: UIView {

    // MARK: UI Components
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .black
        return label
    }()

    private lazy var otpVerificationTextField1: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = ColorsExtension.lightGray
        textField.backgroundColor = ColorsExtension.lightGrayBackground
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = ColorsExtension.lightGray?.cgColor
        textField.layer.cornerRadius = 9
        textField.textAlignment = .center
        textField.autocapitalizationType = .allCharacters
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return textField
    }()

    private lazy var otpVerificationTextField2: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = ColorsExtension.lightGray
        textField.backgroundColor = ColorsExtension.lightGrayBackground
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = ColorsExtension.lightGray?.cgColor
        textField.layer.cornerRadius = 9
        textField.textAlignment = .center
        textField.autocapitalizationType = .allCharacters
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return textField
    }()

    private lazy var otpVerificationTextField3: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = ColorsExtension.lightGray
        textField.backgroundColor = ColorsExtension.lightGrayBackground
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = ColorsExtension.lightGray?.cgColor
        textField.layer.cornerRadius = 9
        textField.textAlignment = .center
        textField.autocapitalizationType = .allCharacters
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return textField
    }()

    private lazy var otpVerificationTextField4: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = ColorsExtension.lightGray
        textField.backgroundColor = ColorsExtension.lightGrayBackground
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = ColorsExtension.lightGray?.cgColor
        textField.layer.cornerRadius = 9
        textField.textAlignment = .center
        textField.autocapitalizationType = .allCharacters
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return textField
    }()

    private lazy var otpVerificationTextField5: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = ColorsExtension.lightGray
        textField.backgroundColor = ColorsExtension.lightGrayBackground
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = ColorsExtension.lightGray?.cgColor
        textField.layer.cornerRadius = 9
        textField.textAlignment = .center
        textField.autocapitalizationType = .allCharacters
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return textField
    }()

    private lazy var otpContainerHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.distribution = .fillEqually
        return stackView
    }()

    // MARK: Initializers

    init(descriptionText: String) {
        super.init(frame: .zero)
        descriptionLabel.text = descriptionText
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

    @objc private func textDidChange(textField: UITextField) {
        let text = textField.text
        if text?.count == 1 {
            switch textField {
                case otpVerificationTextField1:
                    otpVerificationTextField2.becomeFirstResponder()
                case otpVerificationTextField2:
                    otpVerificationTextField3.becomeFirstResponder()
                case otpVerificationTextField3:
                    otpVerificationTextField4.becomeFirstResponder()
                case otpVerificationTextField4:
                    otpVerificationTextField5.becomeFirstResponder()
                case otpVerificationTextField5:
                    otpVerificationTextField5.resignFirstResponder()
            default:
                break
            }
        }
        if text?.count == 0 {
            switch textField {
                case otpVerificationTextField1:
                    otpVerificationTextField1.becomeFirstResponder()
                case otpVerificationTextField2:
                    otpVerificationTextField1.becomeFirstResponder()
                case otpVerificationTextField3:
                    otpVerificationTextField2.becomeFirstResponder()
                case otpVerificationTextField4:
                    otpVerificationTextField3.becomeFirstResponder()
                case otpVerificationTextField5:
                    otpVerificationTextField4.becomeFirstResponder()
            default:
                break
            }
        }
    }
}

extension OtpTextFieldView: SetupView {
    func setup() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(descriptionLabel)
        addSubview(otpContainerHorizontalStackView)
        otpContainerHorizontalStackView.addArrangedSubview(otpVerificationTextField1)
        otpContainerHorizontalStackView.addArrangedSubview(otpVerificationTextField2)
        otpContainerHorizontalStackView.addArrangedSubview(otpVerificationTextField3)
        otpContainerHorizontalStackView.addArrangedSubview(otpVerificationTextField4)
        otpContainerHorizontalStackView.addArrangedSubview(otpVerificationTextField5)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            otpContainerHorizontalStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            otpContainerHorizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            otpContainerHorizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            otpContainerHorizontalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            otpContainerHorizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            otpContainerHorizontalStackView.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
