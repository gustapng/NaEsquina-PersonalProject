//
//  OtpTextFieldView.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 05/09/24.
//

import UIKit

class OtpTextFieldView: UIView {

    // MARK: Variables

    private var numberOfFields: Int
    private var otpTextFields: [UITextField] = []

    // MARK: UI Components

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .black
        return label
    }()

    private lazy var otpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.distribution = .fillEqually
        return stackView
    }()

    // MARK: Initializers

    init(descriptionText: String, numberOfFields: Int) {
        self.numberOfFields = numberOfFields
        super.init(frame: .zero)
        descriptionLabel.text = descriptionText
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

    private func createTextField() -> UITextField {
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
    }

    private func setupFields() {
        for _ in 0 ..< numberOfFields {
            let textField = createTextField()
            self.otpTextFields.append(textField)
            self.otpStackView.addArrangedSubview(textField)
        }
    }

    func getOtpValues() -> String {
        return otpTextFields.compactMap { $0.text }.joined()
    }

    @objc private func textDidChange(textField: UITextField) {
        guard let index = otpTextFields.firstIndex(of: textField) else { return }

        if let text = textField.text, text.count == 1 {
            if index < numberOfFields - 1 {
                otpTextFields[index + 1].becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        } else if textField.text?.isEmpty == true && index > 0 {
            otpTextFields[index - 1].becomeFirstResponder()
        }
    }
}

extension OtpTextFieldView: SetupView {
    func setup() {
        addSubviews()
        setupFields()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(descriptionLabel)
        addSubview(otpStackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            otpStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            otpStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            otpStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            otpStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            otpStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            otpStackView.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
