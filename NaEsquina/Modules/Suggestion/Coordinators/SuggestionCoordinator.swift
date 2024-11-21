//
//  SuggestionCoordinator.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 20/11/24.
//

import UIKit

class SuggestionCoordinator: Coordinator {

    var navigationController: UINavigationController
    var suggestionViewController: SuggestionViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.suggestionViewController = SuggestionViewController()
    }

    func start() {
        suggestionViewController.coordinator = self
        navigationController.pushViewController(suggestionViewController, animated: true)
    }

    func backToPreviousScreen() {
        navigationController.popViewController(animated: true)
    }
}
