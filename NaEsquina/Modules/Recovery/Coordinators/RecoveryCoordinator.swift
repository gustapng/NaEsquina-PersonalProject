//
//  RecoveryCoordinator.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 20/11/24.
//

import UIKit

class RecoveryCoordinator: Coordinator {

    var navigationController: UINavigationController
    var recoveryViewController: RecoveryViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.recoveryViewController = RecoveryViewController()
    }

    func start() {
        recoveryViewController.coordinator = self
        navigationController.pushViewController(recoveryViewController, animated: true)
    }

    func backToPreviousScreen() {
        navigationController.popViewController(animated: true)
    }
}
