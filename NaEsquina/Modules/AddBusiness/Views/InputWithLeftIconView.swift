//
//  InputWithLeftIconView.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 05/10/24.
//

import UIKit

class InputWithLeftIconView: UIView {

    // MARK: - UI Components

    private lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = ColorsExtension.lightGray
        textField.backgroundColor = ColorsExtension.lightGrayBackground
        textField.layer.borderColor = ColorsExtension.lightGray?.cgColor
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 9
        return textField
    }()

    // MARK: - Initializers

    init(placeholder: String, icon: String) {
        super.init(frame: .zero)
        inputTextField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                                  attributes: [NSAttributedString.Key.foregroundColor:
                                                                  ColorsExtension.lightGray ?? UIColor.black])

        inputTextField.addPaddingAndIcon(UIImage(systemName: icon) ?? UIImage(),
                                          ColorsExtension.lightGray ?? UIColor(),
                                          leftPad: 15,
                                          rightPad: 12,
                                          isLeftView: true,
                                          horRotation: false)
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
            inputTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            inputTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            inputTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension InputWithLeftIconView: GetInputValue {
    func getValue() -> String? {
        return inputTextField.text
    }
}
