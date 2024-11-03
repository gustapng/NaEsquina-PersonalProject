//
//  ShowAlert.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 02/11/24.
//

import Foundation
import UIKit

func showAlert(on viewController: UIViewController, title: String, message: String, completion: (() -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        completion?()
    }

    alertController.addAction(okAction)
    viewController.present(alertController, animated: true, completion: nil)
}
