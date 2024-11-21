//
//  Coordinator.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 20/11/24.
//

import UIKit

class UserDataCoordinator: Coordinator {

    var navigationController: UINavigationController
    var userDataViewController: UserDataViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.userDataViewController = UserDataViewController()
    }

    func start() {
        userDataViewController.coordinator = self
        navigationController.pushViewController(userDataViewController, animated: true)
    }

    func backToPreviousScreen() {
        navigationController.popViewController(animated: true)
    }

    func goToUserDataView() {
        let userDataViewController = UserDataViewController()
        navigationController.pushViewController(userDataViewController, animated: true)
    }
}
