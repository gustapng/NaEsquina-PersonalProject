//
//  InputWithDescriptionView.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 05/09/24.
//

import UIKit

class InputWithDescriptionView: UIView {

    // MARK: Variables

    var iconColor: UIColor

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
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 9
        return textField
    }()

    // MARK: - Initializers

    init(descriptionText: String, inputPlaceholder: String, icon: String, leftView: Bool, horRotation: Bool, inputDisabled: Bool) {
        if inputDisabled {
            iconColor = ColorsExtension.lightGrayDisabled ?? UIColor()
        } else {
            iconColor = ColorsExtension.lightGray ?? UIColor()
        }
        super.init(frame: .zero)
        descriptionLabel.text = descriptionText
        configureInputLabel(inputPlaceholder: inputPlaceholder, icon: icon, inputDisabled: inputDisabled)
        inputLabel.addPaddingAndIcon(UIImage(systemName: icon) ?? UIImage(),
                                          iconColor,
                                          leftPad: 15,
                                          rightPad: 12,
                                          isLeftView: leftView,
                                          horRotation: horRotation)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    private func configureInputLabel(inputPlaceholder: String, icon: String, inputDisabled: Bool) {
        if inputDisabled {
           applyDisabledStyle(inputPlaceholder: inputPlaceholder, icon: icon)
        } else {
            applyEnabledStyle(inputPlaceholder: inputPlaceholder, icon: icon)
        }
    }

    private func applyDisabledStyle(inputPlaceholder: String, icon: String) {
        inputLabel.textColor = ColorsExtension.lightGrayDisabled
        inputLabel.backgroundColor = ColorsExtension.lightGrayBackgroundDisabled
        inputLabel.layer.borderColor = ColorsExtension.lightGrayDisabled?.cgColor

        inputLabel.attributedPlaceholder = NSAttributedString(string: inputPlaceholder,
                                                                   attributes: [NSAttributedString.Key.foregroundColor: ColorsExtension
                                                                       .lightGrayDisabled ?? UIColor.black])
    }

    private func applyEnabledStyle(inputPlaceholder: String, icon: String) {
        inputLabel.textColor = ColorsExtension.lightGray
        inputLabel.backgroundColor = ColorsExtension.lightGrayBackground
        inputLabel.layer.borderColor = ColorsExtension.lightGray?.cgColor

        inputLabel.attributedPlaceholder = NSAttributedString(string: inputPlaceholder,
                                                              attributes: [NSAttributedString.Key.foregroundColor: ColorsExtension
                                                                .lightGray ?? UIColor.black])
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
            inputLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
