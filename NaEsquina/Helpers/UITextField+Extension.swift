//
//  UITextField+Extension.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 08/09/24.
//

import UIKit.UITextField

extension UITextField {
    func addPaddingAndIcon(_ image: UIImage, _ color: UIColor, iconSize: CGSize, leftPadding: CGFloat, rightPadding: CGFloat, isLeftView: Bool, horizontalRotation: Bool) {
        let totalPadding = leftPadding + rightPadding
        let frame = CGRect(x: 0, y: 0, width: image.size.width + totalPadding, height: image.size.height)

        let outerView = UIView(frame: frame)
        
        let iconView  = UIImageView(image: image)
        iconView.tintColor = color
        iconView.contentMode = .center
        
        iconView.frame = CGRect(x: leftPadding, y: 0, width: iconSize.width, height: iconSize.height)

        if horizontalRotation {
            iconView.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        
        if isLeftView {
            iconView.frame = CGRect(x: leftPadding, y: 0, width: image.size.width, height: image.size.height)
            outerView.addSubview(iconView)
            leftViewMode = .always
            leftView = outerView
        } else {
            iconView.frame = CGRect(x: rightPadding, y: 0, width: image.size.width, height: image.size.height)
            outerView.addSubview(iconView)
            rightViewMode = .always
            rightView = outerView
        }
    }
}

