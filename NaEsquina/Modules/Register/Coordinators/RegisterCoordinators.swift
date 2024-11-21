//
//  RegisterCoordinators.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 20/11/24.
//

import UIKit

class RegisterCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var registerViewController: RegisterViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.registerViewController = RegisterViewController()
    }

    func start() {
        registerViewController.coordinator = self
        navigationController.pushViewController(registerViewController, animated: true)
    }

    func backToPreviousScreen() {
        navigationController.popViewController(animated: true)
    }

    func goToUserDataView() {
        let userDataViewController = RegisterViewController()
        navigationController.pushViewController(userDataViewController, animated: true)
    }
}
