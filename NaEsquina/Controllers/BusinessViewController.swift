//
//  FilterViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 18/09/24.
//

import UIKit

class BusinessViewController: UIViewController {

    // MARK: UI Components

    private lazy var sheetInfoView: SheetInfoView = {
        let sheetInfoView = SheetInfoView(title: "Adicionar comércio", subtitle: "Os dados enviados serão analisados e, se aprovados, o comércio será adicionado ao app em até 48 horas.")
        sheetInfoView.translatesAutoresizingMaskIntoConstraints = false
        return sheetInfoView
    }()
        
    // MARK: Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension BusinessViewController: SetupView {
    func setup() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(sheetInfoView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            sheetInfoView.topAnchor.constraint(equalTo: view.topAnchor),
            sheetInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sheetInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
