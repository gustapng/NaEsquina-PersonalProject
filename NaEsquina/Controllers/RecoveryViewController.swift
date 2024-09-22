//
//  RecoveryViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 08/09/24.
//

import UIKit

class RecoveryViewController: UIViewController {

    // MARK: UI Components

    private lazy var backButton: UIButton = {
        return UIButton.createCustomBackButton(target: self, action: #selector(backButtonTapped), borderColor: ColorsExtension.lightGray ?? .black)
    }()

    private lazy var imageWithDescription: ImageWithInfoView = {
        let view = ImageWithInfoView(image: Constants.PasswordRecovery.image, mainMessage: Constants.PasswordRecovery.mainMessage, description: Constants.PasswordRecovery.description)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Functions

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension RecoveryViewController: SetupView {
    func setup() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(backButton)
        view.addSubview(imageWithDescription)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            imageWithDescription.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            imageWithDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            imageWithDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
}
