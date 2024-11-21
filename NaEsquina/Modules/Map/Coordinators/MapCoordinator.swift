//
//  MapCoordinator.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 20/11/24.
//

import UIKit

class MapCoordinator: Coordinator {
    var navigationController: UINavigationController
    var mapViewController: MapViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.mapViewController = MapViewController()
    }

    func start() {
        mapViewController.coordinator = self
        navigationController.pushViewController(mapViewController, animated: true)
    }

    func goToAddBusinessView() {
        let addBusinessViewController = AddBusinessViewController()
        if let sheet = addBusinessViewController.sheetPresentationController {
            sheet.detents = [.custom(resolver: { _ in 600 })]
            sheet.prefersGrabberVisible = true
        }
        navigationController.present(addBusinessViewController, animated: true, completion: nil)
    }

    func goToFilterView() {
        let filterViewController = FilterViewController()
        if let sheet = filterViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        navigationController.present(filterViewController, animated: true, completion: nil)
    }

    func goToUserView() {
        let userViewController = UserViewController()
        navigationController.pushViewController(userViewController, animated: true)
    }

    func backToPreviousScreen() {
        navigationController.popViewController(animated: true)
    }
}
