//
//  InputWithLeftIconView.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 05/10/24.
//

import UIKit

class FilterPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    // MARK: - Attributes

    var options = [
        "Alimentação e Bebidas", "Serviços", "Compras", "Saúde"
    ]

    // MARK: - UI Components

    private lazy var optionPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()

    private lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = ColorsExtension.lightGray
        textField.backgroundColor = ColorsExtension.lightGrayBackground
        textField.layer.borderColor = ColorsExtension.lightGray?.cgColor
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 9
        textField.inputView = optionPickerView
        textField.delegate = self
        return textField
    }()

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        options[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        inputTextField.text = options[row]
        inputTextField.resignFirstResponder()
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = options[row]
        label.textColor = ColorsExtension.purpleMedium
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }

    // MARK: Initializers

    init() {
        super.init(frame: .zero)
        inputTextField.attributedPlaceholder = NSAttributedString(string: "Tipo de comércio",
                                                                  attributes: [NSAttributedString.Key.foregroundColor:
                                                                  ColorsExtension.lightGray ?? UIColor.black])

        inputTextField.addPaddingAndIcon(UIImage(systemName: "option") ?? UIImage(),
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

extension FilterPickerView: SetupView {
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
