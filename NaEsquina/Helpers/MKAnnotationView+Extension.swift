//
//  UITextField+Extension.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 22/09/24.
//

import UIKit
import MapKit

extension MKAnnotationView {
    func configureCustomAnnotation(title: String?, titleColor: UIColor) {
    
        self.subviews.forEach { $0.removeFromSuperview() }
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = titleColor
        titleLabel.font = .systemFont(ofSize: 12, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 14),
        ])
    }
}
