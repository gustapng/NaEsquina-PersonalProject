//
//  CurrentScreenDescriptionView.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 08/09/24.
//

import UIKit

class CurrentViewDescriptionView: UIView {

    // MARK: UI Components

    private lazy var viewTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .semibold)
        label.textColor = .black
        return label
    }()

    private lazy var viewDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = ColorsExtension.gray
        return label
    }()

    // MARK: Initializers
    init(viewTitle: String, viewDescription: String) {
        super.init(frame: .zero)
        viewTitleLabel.text = viewTitle
        viewDescriptionLabel.text = viewDescription
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrentViewDescriptionView: SetupView {
    func setup() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(viewTitleLabel)
        addSubview(viewDescriptionLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            viewTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            viewTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            viewTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

            viewDescriptionLabel.topAnchor.constraint(equalTo: viewTitleLabel.bottomAnchor, constant: 12),
            viewDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            viewDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 30)
        ])
    }
}
