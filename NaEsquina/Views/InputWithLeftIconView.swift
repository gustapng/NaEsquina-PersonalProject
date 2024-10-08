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
        let leftView = UIView(frame: CGRect(x: 10, y: 0, width: 45, height: 40))
        let icon = UIImageView(frame: CGRect(x: 15, y: 10, width: 20, height: 20))
        icon.image = UIImage(systemName: "bag")
        icon.tintColor = ColorsExtension.lightGray
        leftView.addSubview(icon)

        let input = UITextField()
        input.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        input.translatesAutoresizingMaskIntoConstraints = false
        input.textColor = ColorsExtension.lightGray
        input.backgroundColor = ColorsExtension.lightGrayBackground
        input.layer.borderWidth = 1
        input.layer.borderColor = ColorsExtension.lightGray?.cgColor
        input.layer.cornerRadius = 9
        input.leftView = leftView
        input.leftViewMode = .always
        return input
    }()

    // MARK: Initializers

    init(placeholder: String, icon: String) {
        super.init(frame: .zero)
        inputTextField.placeholder = placeholder
        if let leftViewIcon = (inputTextField.leftView?.subviews.first as? UIImageView) {
            leftViewIcon.image = UIImage(systemName: icon) // Usa o valor passado no init
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
            inputTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
