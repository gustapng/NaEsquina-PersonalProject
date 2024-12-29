
//
//  BusinessDetailsViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 18/09/24.
//

import UIKit

class BusinessDetailsViewController: UIViewController {

    // MARK: - Attributes
    var businessData: BusinessLocationFirebaseResponse?

    // MARK: - UI Components

    private lazy var sheetDetailsView: SheetBusinessDetailsView = {
        let sheetView = SheetBusinessDetailsView()
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        return sheetView
    }()

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if let businessData = businessData {
            sheetDetailsView.configure(with: businessData)
        }
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
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            sheetDetailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            sheetDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sheetDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
}
