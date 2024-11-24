//
//  MainCoordinator.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 23/11/24.
//

import UIKit

class MainCoordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = LoginViewController()
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func navigateToRecoveryViewController() {
        print("aqui2")
        let vc = RecoveryViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
