//
//  ImageWithInfoView.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 21/09/24.
//

import UIKit

class ImageWithInfoView: UIView {

    // MARK: UI Components

    private lazy var illustrationImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    private lazy var mainMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .semibold)
        label.textColor = .black
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = ColorsExtension.gray
        label.numberOfLines = 0
        return label
    }()

    // MARK: Initializers

    init(image: String, mainMessage: String, description: String) {
        super.init(frame: .zero)
        self.illustrationImage.image = UIImage(named: image)
        self.mainMessageLabel.text = mainMessage
        self.descriptionLabel.text = description
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageWithInfoView: SetupView {
    func setup() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(illustrationImage)
        addSubview(mainMessageLabel)
        addSubview(descriptionLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            illustrationImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            illustrationImage.heightAnchor.constraint(equalToConstant: 300),
            illustrationImage.widthAnchor.constraint(equalToConstant: 300),

            mainMessageLabel.topAnchor.constraint(equalTo: illustrationImage.bottomAnchor, constant: 30),
            mainMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: mainMessageLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
