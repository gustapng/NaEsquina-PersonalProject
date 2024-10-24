
//
//  FilterViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 18/09/24.
//

import UIKit

class BusinessDetailsViewController: UIViewController {

    // MARK: UI Components
    
    private lazy var sheetDetailsView: SheetBusinessDetailsView = {
        let sheetView = SheetBusinessDetailsView()
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        return sheetView
    }()
    
    private lazy var addBussinessButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        button.setTitle("Reportar problema", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorsExtension.purpleMedium
        button.layer.cornerRadius = 9
        // TODO CREATE ADCTION FOR THIS BUTTON
//        button.addTarget(self, action: #selector(goToMainMenuView), for: .touchUpInside)
        button.layer.shadowColor = ColorsExtension.purpleLight?.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 0
        return button
    }()
        
    // MARK: Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension BusinessDetailsViewController: SetupView {
    func setup() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(sheetDetailsView)
        view.addSubview(addBussinessButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            sheetDetailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            sheetDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sheetDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            addBussinessButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addBussinessButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            addBussinessButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            addBussinessButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
