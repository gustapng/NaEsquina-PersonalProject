//
//  FilterViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 18/09/24.
//

import UIKit

class FilterViewController: UIViewController {

    // MARK: UI Components

    private lazy var viewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .semibold)
        label.textColor = .black
        label.text = "This is a sheet view"
        label.textAlignment = .center
        return label
    }()
        
    // MARK: Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension FilterViewController: SetupView {
    func setup() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(viewLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            viewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
