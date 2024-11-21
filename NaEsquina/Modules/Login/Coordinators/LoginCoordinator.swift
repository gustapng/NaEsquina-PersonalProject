//
//  LoginCoordinator.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 20/11/24.
//

import UIKit

class LoginCoordinator: Coordinator {

    var navigationController: UINavigationController
    private let loginViewController: LoginViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.loginViewController = LoginViewController()
        self.loginViewController.coordinator = self
    }

    func start() {
        navigationController.pushViewController(loginViewController, animated: true)
    }

    func navigateToMapView() {
        let mapViewController = MapViewController()
        navigationController.pushViewController(mapViewController, animated: true)
    }
}
