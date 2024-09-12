//
//  UIButton+Extension.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 11/09/24.
//

import UIKit.UIButton

extension UIButton {
    static func createCustomBackButton(target: Any?, action: Selector, borderColor: UIColor = .black, borderWidth: CGFloat = 1.5, cornerRadius: CGFloat = 9, imageSize: CGFloat = 12) -> UIButton {

        let backButton = UIButton(type: .system)

        let imageConfig = UIImage.SymbolConfiguration(pointSize: imageSize, weight: .regular) // Reduz o tamanho da imagem
        let resizedImage = UIImage(systemName: "arrow.backward", withConfiguration: imageConfig)

        var config = UIButton.Configuration.plain()
        config.image = resizedImage
        config.baseForegroundColor = .black // Cor do ícone
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0) // Remove padding interno

        backButton.configuration = config
        backButton.layer.borderColor = borderColor.cgColor
        backButton.layer.borderWidth = borderWidth
        backButton.layer.cornerRadius = cornerRadius
        backButton.clipsToBounds = true

        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 35),
            backButton.heightAnchor.constraint(equalToConstant: 35),
        ])

        backButton.addTarget(target, action: action, for: .touchUpInside)

        return backButton
    }
}
