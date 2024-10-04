//
//  FilterViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 18/09/24.
//

import UIKit

class AddBusinessViewController: UIViewController {

    // MARK: UI Components

    private lazy var sheetInfoView: SheetInfoView = {
        let sheetInfoView = SheetInfoView(title: "Adicionar comércio", subtitle: "Os dados enviados serão analisados e, se aprovados, o comércio será adicionado ao app em até 48 horas.")
        sheetInfoView.translatesAutoresizingMaskIntoConstraints = false
        return sheetInfoView
    }()
    
    // REFACTOR THIS FOR VIEW
    private lazy var inputTextField: UITextField = {
        let leftView = UIView(frame: CGRect(x: 10, y: 0, width: 45, height: 40))
        let icon = UIImageView(frame: CGRect(x: 15, y: 10, width: 20, height: 20))
        icon.image = UIImage(systemName: "bag")
        icon.tintColor = ColorsExtension.lightGray
        leftView.addSubview(icon)

        let input = UITextField()
        input.placeholder = "Teste"
        input.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        input.translatesAutoresizingMaskIntoConstraints = false
        input.textColor = ColorsExtension.lightGray
        input.backgroundColor = ColorsExtension.lightGrayBackground
        input.layer.borderWidth = 1.5
        input.layer.borderColor = ColorsExtension.lightGray?.cgColor
        input.layer.cornerRadius = 9
        input.leftView = leftView
        input.leftViewMode = .always
        return input
    }()
        
    // MARK: Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension AddBusinessViewController: SetupView {
    func setup() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(sheetInfoView)
        view.addSubview(inputTextField)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            sheetInfoView.topAnchor.constraint(equalTo: view.topAnchor),
            sheetInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sheetInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            inputTextField.topAnchor.constraint(equalTo: sheetInfoView.bottomAnchor, constant: 160),
            inputTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            inputTextField.heightAnchor.constraint(equalToConstant: 45),
            inputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
