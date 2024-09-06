//
//  ViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 03/09/24.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: UI Components
    
    private lazy var ViewTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login"
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private lazy var ViewDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Faça login para continuar usando o aplicativo"
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = ColorsExtension.gray
        return label
    }()
    
    private lazy var inputWithDescriptionView: InputWithDescriptionView = {
        let view = InputWithDescriptionView(descriptionText: "Email", inputLabelPlaceholder: "Seu email")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 1
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true // Defina uma altura mínima
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension ViewController: ViewCode {
    func setup() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        setupStyle()
    }
    
    func addSubviews() {
        view.addSubview(ViewTitleLabel)
        view.addSubview(ViewDescriptionLabel)
        view.addSubview(inputWithDescriptionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            ViewTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            ViewTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            ViewTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            ViewDescriptionLabel.topAnchor.constraint(equalTo: ViewTitleLabel.bottomAnchor, constant: 12),
            ViewDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            ViewDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 30),

            inputWithDescriptionView.topAnchor.constraint(equalTo: ViewDescriptionLabel.bottomAnchor, constant: 24),
            inputWithDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputWithDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

        ])
    }
    
    func setupStyle() {
        
    }
}
