//
//  InputWithLeftIconView.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 05/10/24.
//

import UIKit

class InputWithLeftIconView: UIView {

    // MARK: UI Components

    private lazy var inputTextField: UITextField = {
        let leftView = UIView(frame: CGRect(x: 10, y: 0, width: 50, height: 40))
        let icon = UIImageView(frame: CGRect(x: 15, y: 10, width: 20, height: 20))
        icon.tintColor = ColorsExtension.lightGray
        icon.contentMode = .scaleAspectFit
        leftView.addSubview(icon)

        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = ColorsExtension.lightGray
        textField.backgroundColor = ColorsExtension.lightGrayBackground
        textField.layer.borderColor = ColorsExtension.lightGray?.cgColor
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 9
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()

    // MARK: Initializers

    init(placeholder: String, icon: String) {
        super.init(frame: .zero)
        inputTextField.placeholder = placeholder
        let attributes = [NSAttributedString.Key.foregroundColor: ColorsExtension.lightGray ?? UIColor.gray]
        inputTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)

        if let leftViewIcon = (inputTextField.leftView?.subviews.first as? UIImageView) {
            leftViewIcon.image = UIImage(systemName: icon)
        }
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InputWithLeftIconView: SetupView {
    func setup() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(inputTextField)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            inputTextField.topAnchor.constraint(equalTo: topAnchor),
            inputTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
