//
//  LabelButton.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 05/09/24.
//

import UIKit

class InputWithDescriptionView: UIView {

    //MARK: UI Components
    
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
        textField.backgroundColor = .lightGray // Adicione uma cor de fundo temporária
        textField.borderStyle = .roundedRect // Adicione um estilo de borda para melhor visualização
        return textField
    }()
    
    //MARK: Initializers
    
    init(descriptionText: String, inputLabelPlaceholder: String) {
        super.init(frame: .zero)
        descriptionLabel.text = descriptionText
        inputLabel.placeholder = inputLabelPlaceholder
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InputWithDescriptionView: ViewCode {
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
            inputLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            inputLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupStyle() {
        
    }
}
