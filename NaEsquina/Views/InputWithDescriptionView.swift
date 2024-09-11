//
//  LabelButton.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 05/09/24.
//

import UIKit

class InputWithDescriptionView: UIView {

    // MARK: UI Components
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .black
        return label
    }()

    private lazy var inputLabel: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = ColorsExtension.lightGray
        textField.backgroundColor = ColorsExtension.lightGrayBackground
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = ColorsExtension.lightGray?.cgColor
        textField.layer.cornerRadius = 9
        return textField
    }()

    // MARK: Initializers

    init(descriptionText: String, inputPlaceholder: String, isPassword: Bool, icon: String, iconSize: CGSize, leftView: Bool, horRotation: Bool) {
        super.init(frame: .zero)
        descriptionLabel.text = descriptionText
        inputLabel.placeholder = inputPlaceholder
        let icon = UIImage(systemName: icon) ?? UIImage()
        let iconColor = ColorsExtension.lightGray ?? UIColor()
        print(iconSize)
        inputLabel.addPaddingAndIcon(icon, iconColor, iconSize: iconSize, leftPad: 15, rightPad: 12, isLeftView: leftView, horRotation: horRotation)
        if isPassword {
            setupPasswordVisibilityToggle()
        }
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

    private func setupPasswordVisibilityToggle() {
        let toggleButton = UIButton(type: .system)
        toggleButton.setImage(UIImage(systemName: "eye"), for: .normal)
        toggleButton.tintColor = .gray
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)

        toggleButton.imageView?.contentMode = .scaleAspectFit
        toggleButton.frame.size = CGSize(width: 16, height: 16)

        let rightViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        rightViewContainer.addSubview(toggleButton)

        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toggleButton.centerYAnchor.constraint(equalTo: rightViewContainer.centerYAnchor),
            toggleButton.trailingAnchor.constraint(equalTo: rightViewContainer.trailingAnchor, constant: -8)
        ])

        inputLabel.rightView = rightViewContainer
        inputLabel.rightViewMode = .always
    }

    @objc private func togglePasswordVisibility() {
        inputLabel.isSecureTextEntry.toggle()

        let button = inputLabel.rightView?.subviews.first as? UIButton
        let imageName = inputLabel.isSecureTextEntry ? "eye" : "eye.slash"
        button?.setImage(UIImage(systemName: imageName), for: .normal)
    }
}

extension InputWithDescriptionView: SetupView {
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
