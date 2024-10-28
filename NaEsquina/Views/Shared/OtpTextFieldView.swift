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

    private lazy var otpContainerHorizontalStackView: UIStackView = {
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
            self.otpContainerHorizontalStackView.addArrangedSubview(textField)
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
        } else if textField.text?.count == 0 && index > 0 {
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
        addSubview(otpContainerHorizontalStackView)
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
