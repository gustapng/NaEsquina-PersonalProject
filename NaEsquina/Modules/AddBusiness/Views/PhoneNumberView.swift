//
//  InputWithLeftIconView.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 05/10/24.
//

import UIKit

class PhoneNumberView: UIView, UITextFieldDelegate {

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
        textField.keyboardType = .numberPad
        textField.delegate = self
        return textField
    }()

    // MARK: - Functions

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)

        let newCleanedNumber = newText.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)

        if newCleanedNumber.count > 11 {
            return false
        }

        if string.isEmpty {
            let indexToDelete = range.location
            if indexToDelete == 3 || indexToDelete == 10 {
                let adjustedRange = NSRange(location: range.location - 1, length: range.length + 1)
                let adjustedText = (currentText as NSString).replacingCharacters(in: adjustedRange, with: string)
                textField.text = formatPhoneNumber(adjustedText.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression))
                return false
            }

            if indexToDelete == 2 {
                textField.text = ""
                return false
            }
        }

        let formattedText = formatPhoneNumber(newCleanedNumber)
        textField.text = formattedText

        return false
    }

    private func formatPhoneNumber(_ number: String) -> String {
        switch number.count {
        case 0...2:
            return "(\(number))"
        case 3...6:
            let ddd = number.prefix(2)
            let prefix = number.suffix(from: number.index(number.startIndex, offsetBy: 2))
            return "(\(ddd)) \(prefix)"
        case 7...11:
            let ddd = number.prefix(2)
            let firstPart = number[number.index(number.startIndex, offsetBy: 2)..<number.index(number.startIndex, offsetBy: 7)]
            let secondPart = number.suffix(from: number.index(number.startIndex, offsetBy: 7))
            return "(\(ddd)) \(firstPart)-\(secondPart)"
        default:
            return number
        }
      }

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        inputTextField.attributedPlaceholder = NSAttributedString(string: "Telefone",
                                                                  attributes: [NSAttributedString.Key.foregroundColor:
                                                                  ColorsExtension.lightGray ?? UIColor.black])

        inputTextField.addPaddingAndIcon(UIImage(systemName: "phone") ?? UIImage(),
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

extension PhoneNumberView: SetupView {
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

extension PhoneNumberView: GetInputValue {
    func getValue() -> String? {
        return inputTextField.text
    }
}
