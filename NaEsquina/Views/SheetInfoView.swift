//
//  SheetInfoView.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 01/10/24.
//

import UIKit

class SheetInfoView: UIView {

    // MARK: UI Components

    private lazy var viewTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private lazy var viewSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = ColorsExtension.lightGray
        label.numberOfLines = 0
        return label
    }()

    // MARK: Initializers
    
    init(title: String, subtitle: String) {
        super.init(frame: .zero)
        viewTitleLabel.text = title
        viewSubtitleLabel.text = subtitle
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SheetInfoView: SetupView {
    func setup() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(viewTitleLabel)
        addSubview(viewSubtitleLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            viewTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            viewTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            viewSubtitleLabel.topAnchor.constraint(equalTo: viewTitleLabel.bottomAnchor, constant: 6),
            viewSubtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewSubtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
