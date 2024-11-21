//
//  UserCoordinator.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 20/11/24.
//

import UIKit

class UserCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var userViewController: UserViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.userViewController = UserViewController()
    }

    func start() {
        userViewController.coordinator = self
        navigationController.pushViewController(userViewController, animated: true)
    }

    func backToPreviousScreen() {
        navigationController.popViewController(animated: true)
    }

    func goToUserDataView() {
        let userDataViewController = UserDataViewController()
        navigationController.pushViewController(userDataViewController, animated: true)
    }

    func goToSuggestionView() {
        let suggestionViewController = SuggestionViewController()
        navigationController.pushViewController(suggestionViewController, animated: true)
    }

    func returnToLoginView() {
        let loginViewController = LoginViewController()
        navigationController.setViewControllers([loginViewController], animated: true)
    }
}
