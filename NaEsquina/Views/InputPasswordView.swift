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
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = ColorsExtension.lightGray
        textField.backgroundColor = ColorsExtension.lightGrayBackground
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = ColorsExtension.lightGray?.cgColor
        textField.layer.cornerRadius = 9
        textField.isSecureTextEntry = true
        return textField
    }()
    
    // Botão para alternar a visibilidade da senha
    private lazy var toggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()
    
    //MARK: Initializers
    
    init(descriptionText: String, inputLabelPlaceholder: String, iconSize: CGSize) {
        super.init(frame: .zero)
        descriptionLabel.text = descriptionText
        inputLabel.placeholder = inputLabelPlaceholder
        let icon = UIImage(systemName: "key.horizontal") ?? UIImage()
        let iconColor = ColorsExtension.lightGray ?? UIColor()
        inputLabel.addPaddingAndIcon(icon, iconColor, iconSize: iconSize, leftPadding: 15, rightPadding: 12, isLeftView: true, horizontalRotation: true)
        configurePasswordVisibility()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    
    private func configurePasswordVisibility() {
        toggleButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        inputLabel.rightView = toggleButton
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
