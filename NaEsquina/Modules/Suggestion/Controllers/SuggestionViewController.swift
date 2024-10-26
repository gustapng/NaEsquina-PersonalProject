//
//  SuggestionViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 17/10/24.
//

import UIKit

class SuggestionViewController: UIViewController {

    // MARK: - UI Components

    private lazy var backButton: UIButton = {
        return UIButton.createCustomBackButton(target: self, action: #selector(backButtonTapped), borderColor: ColorsExtension.lightGray ?? .black)
    }()

    private lazy var currentViewDescriptionView: CurrentViewDescriptionView = {
        let view = CurrentViewDescriptionView(viewTitle: "Sugestões", viewDescription: "Tem alguma uma sugestão? Conte para nós.")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .black
        label.text = "Sugestão"
        return label
    }()

    private lazy var inputLabel: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 1.5
        textView.layer.cornerRadius = 9
        textView.text = "Sugestão ou erro? Conte-nos!"
        textView.textColor = ColorsExtension.lightGray
        textView.backgroundColor = ColorsExtension.lightGrayBackground
        textView.layer.borderColor = ColorsExtension.lightGray?.cgColor
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return textView
    }()
    
    private lazy var sendSuggestionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        button.setTitle("Enviar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorsExtension.purpleMedium
        button.layer.cornerRadius = 9
        button.addTarget(self, action: #selector(sendSuggestion), for: .touchUpInside)
        button.layer.shadowColor = ColorsExtension.purpleLight?.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 0
        return button
    }()

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Actions

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func sendSuggestion() {
        print("ACTION DE ENVIAR SUGESTAO")
    }
}

extension SuggestionViewController: SetupView {
    func setup() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(backButton)
        view.addSubview(currentViewDescriptionView)
        view.addSubview(descriptionLabel)
        view.addSubview(inputLabel)
        view.addSubview(sendSuggestionButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),

            currentViewDescriptionView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            currentViewDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            currentViewDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            descriptionLabel.topAnchor.constraint(equalTo: currentViewDescriptionView.bottomAnchor, constant: 100),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            inputLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            inputLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            inputLabel.heightAnchor.constraint(equalToConstant: 400),
            
            sendSuggestionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            sendSuggestionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sendSuggestionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            sendSuggestionButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
