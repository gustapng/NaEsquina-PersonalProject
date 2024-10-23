
//
//  SheetInfoView.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 01/10/24.
//

import UIKit

class SheetBusinessDetailsView: UIView {

    // MARK: UI Components
    
    private lazy var businessImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "comercio"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var viewTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .semibold)
        label.textColor = ColorsExtension.purpleLight
        label.text = "teste"
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = ColorsExtension.lightGray
        label.numberOfLines = 0
        label.text = "endereço"
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = ColorsExtension.lightGray
        label.numberOfLines = 0
        label.text = "telefone"
        return label
    }()

    // MARK: Initializers
    
    init() {
        super.init(frame: .zero)
//        viewTitleLabel.text = title
//        viewSubtitleLabel.text = subtitle
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SheetBusinessDetailsView: SetupView {
    func setup() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(businessImageView)
        addSubview(viewTitleLabel)
        addSubview(addressLabel)
        addSubview(phoneLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            businessImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            businessImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            businessImageView.heightAnchor.constraint(equalToConstant: 180),
//            businessImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            businessImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            viewTitleLabel.topAnchor.constraint(equalTo: businessImageView.bottomAnchor, constant: 16),
            viewTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            addressLabel.topAnchor.constraint(equalTo: viewTitleLabel.bottomAnchor, constant: 6),
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            phoneLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 6),
            phoneLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
