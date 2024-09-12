//
//  InputPasswordView.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 09/09/24.
//

import UIKit

class InputPasswordView: UIView {

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .black
        return label
    }()

    private lazy var inputLabel: UITextField = {
        // Icon Config
        let desiredIconSize = CGSize(width: 25, height: 25)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40 + 12, height: 30)) // Adicionando 12 de padding extra
        let icon = UIImage(systemName: "key.horizontal")
        let iconView = UIImageView(image: icon)
        let rightPaddingView = UIView(frame: CGRect(x: iconView.frame.maxX + 5, y: 0, width: 12, height: 30))
        iconView.tintColor = ColorsExtension.lightGray
        iconView.transform = CGAffineTransform(scaleX: -1, y: 1)
        iconView.contentMode = .scaleAspectFit
        iconView.frame = CGRect(x: 15, y: 2.5, width: desiredIconSize.width, height: desiredIconSize.height)
        paddingView.addSubview(iconView)
        paddingView.addSubview(rightPaddingView)

        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = ColorsExtension.lightGray
        textField.backgroundColor = ColorsExtension.lightGrayBackground
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = ColorsExtension.lightGray?.cgColor
        textField.layer.cornerRadius = 9
        textField.isSecureTextEntry = true
        textField.leftView = paddingView
        textField.leftViewMode = .always

        return textField
    }()

    private lazy var toggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()

    // MARK: Initializers

    init(descriptionText: String, inputLabelPlaceholder: String) {
        super.init(frame: .zero)
        descriptionLabel.text = descriptionText
        inputLabel.placeholder = inputLabelPlaceholder
        configurePasswordVisibility()
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

    private func configurePasswordVisibility() {
         let buttonSize: CGFloat = 30
         let rightPadding: CGFloat = 12
         let buttonContainer = UIView(frame: CGRect(x: 0, y: 0, width: buttonSize + rightPadding, height: buttonSize))

         toggleButton.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
         toggleButton.tintColor = ColorsExtension.lightGray

         buttonContainer.addSubview(toggleButton)
        
         inputLabel.rightView = buttonContainer
         inputLabel.rightViewMode = .always
    }

    @objc private func togglePasswordVisibility() {
        inputLabel.isSecureTextEntry.toggle()
        toggleButton.isSelected.toggle()
    }
}

extension InputPasswordView: SetupView {
    func setup() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(descriptionLabel)
        addSubview(inputLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            inputLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            inputLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            inputLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            inputLabel.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
