
//
//  BusinessDetailsViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 18/09/24.
//

import UIKit

class BusinessDetailsViewController: UIViewController {

    // MARK: - UI Components

    private lazy var sheetDetailsView: SheetBusinessDetailsView = {
        let sheetView = SheetBusinessDetailsView()
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        return sheetView
    }()

    private lazy var reportProblemButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        button.setTitle("Reportar problema", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorsExtension.purpleMedium
        button.layer.cornerRadius = 9
        // TODO: CRIAR A ACAO DESSE BOTAO
//        button.addTarget(self, action: #selector(goToMainMenuView), for: .touchUpInside)
        button.layer.shadowColor = ColorsExtension.purpleLight?.cgColor ?? UIColor.purple.cgColor
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
}

extension BusinessDetailsViewController: SetupView {
    func setup() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(sheetDetailsView)
        view.addSubview(reportProblemButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            sheetDetailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            sheetDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sheetDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            reportProblemButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            reportProblemButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            reportProblemButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            reportProblemButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
