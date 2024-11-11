//
//  LoadingView.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 10/11/24.
//

import UIKit

class LoadingView: UIView {

    // MARK: Attributes

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        return activityIndicator
    }()

    // MARK: Functions

    func startAnimating() {
        self.isHidden = false
        activityIndicatorView.startAnimating()
    }

    func stopAnimating() {
        self.isHidden = true
        activityIndicatorView.stopAnimating()
    }

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoadingView: SetupView {
    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.layer.cornerRadius = 8
        self.isHidden = true
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(activityIndicatorView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
