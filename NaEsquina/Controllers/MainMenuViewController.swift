//
//  mainMenuViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 09/09/24.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    // MARK: UI Components

    private lazy var backButton: UIButton = {
        return UIButton.createCustomBackButton(target: self, action: #selector(backButtonTapped), borderColor: ColorsExtension.lightGray ?? .black)
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

extension MainMenuViewController: SetupView {
    func setup() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(backButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
        ])
    }
}
