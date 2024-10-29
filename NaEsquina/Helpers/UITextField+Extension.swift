//
//  UITextField+Extension.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 08/09/24.
//

import UIKit.UITextField

extension UITextField {
    func addPaddingAndIcon(_ img: UIImage,
                           _ color: UIColor,
                           leftPad: CGFloat,
                           rightPad: CGFloat,
                           isLeftView: Bool,
                           horRotation: Bool) {

        let totalPadding = leftPad + rightPad
        let frame = CGRect(x: 0, y: 0, width: img.size.width + totalPadding, height: img.size.height)

        let outerView = UIView(frame: frame)

        let iconView = UIImageView(image: img)
        iconView.tintColor = color
        iconView.contentMode = .center

        if horRotation {
            iconView.transform = CGAffineTransform(scaleX: -1, y: 1)
        }

        if isLeftView {
            iconView.frame = CGRect(x: leftPad, y: 0, width: img.size.width, height: img.size.height)
            outerView.addSubview(iconView)
            leftViewMode = .always
            leftView = outerView
        } else {
            iconView.frame = CGRect(x: rightPad, y: 0, width: img.size.width, height: img.size.height)
            outerView.addSubview(iconView)
            rightViewMode = .always
            rightView = outerView
        }
    }
}
