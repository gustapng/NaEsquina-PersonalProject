//
//  Coordinator.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 20/11/24.
//

import UIKit
import LocalAuthentication
import CoreLocation

class CoordinatorFlowController: NSObject, UIAdaptivePresentationControllerDelegate {
    private var navigationController: UINavigationController

    init(navigationController: UINavigationController) {	
        self.navigationController = navigationController
    }

    func start() -> UIViewController {
        let loginViewController =  LoginViewController()
        loginViewController.coordinator = self
        navigationController = UINavigationController(rootViewController: loginViewController)
        return navigationController
    }

    func backToPreviousScreen() {
        navigationController.popViewController(animated: true)
    }

    // MARK: LOGIN FUNCTIONS

    func getUserSettings(completion: @escaping (UserSettings) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let settings = UserSettings(showWelcomeMessage: true)
            DispatchQueue.main.async {
                completion(settings)
            }
        }
    }

    struct UserSettings {
        let showWelcomeMessage: Bool
    }

    func authenticateUserWithFaceID(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Autentique-se para acessar o menu") { success, error in
                DispatchQueue.main.async {
                    completion(success)
                }
            }
        } else {
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
}

extension CoordinatorFlowController: LoginCoordinator {
    func navigateToRecoveryView() {
        let recoveryViewController = RecoveryViewController()
        recoveryViewController.coordinator = self
        navigationController.pushViewController(recoveryViewController, animated: true)
    }

    func navigateToRegisterView() {
        let registerViewController = RegisterViewController()
        registerViewController.coordinator = self
        navigationController.pushViewController(registerViewController, animated: true)
    }

    func navigateToMenuView() {
        let menuViewController = MenuViewController()
        menuViewController.coordinator = self
        navigationController.pushViewController(menuViewController, animated: true)
    }

    func navigateToMenuViewWithAlert() {
        let menuViewController = MenuViewController()
        menuViewController.coordinator = self
        navigationController.pushViewController(menuViewController, animated: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let alertController = UIAlertController(title: "Bem-vindo!", message: "Login realizado com sucesso!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            menuViewController.present(alertController, animated: true, completion: nil)
        }
    }
}

extension CoordinatorFlowController: MenuCoordinator {
    func openNewBusinessSheet(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let addBusinessViewController = AddBusinessViewController()

        if let menuViewController = navigationController.topViewController as? MenuViewController {
            addBusinessViewController.delegate = menuViewController
            addBusinessViewController.delegateBusiness = menuViewController
            addBusinessViewController.latitude = latitude
            addBusinessViewController.longitude = longitude
        }

        if let sheet = addBusinessViewController.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }

        addBusinessViewController.presentationController?.delegate = self

        navigationController.topViewController?.present(addBusinessViewController, animated: true)
    }

    func openFilterSheet() {
        let filterViewController = FilterViewController()

        if let sheet = filterViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }

        navigationController.topViewController?.present(filterViewController, animated: true)
    }

    func openBusinessDetailsSheet(businessData: BusinessLocationFirebaseResponse) {
        DispatchQueue.main.async {
            let businessDetailsViewController = BusinessDetailsViewController()
            businessDetailsViewController.businessData = businessData

            if let sheet = businessDetailsViewController.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }

            self.navigationController.topViewController?.present(businessDetailsViewController, animated: true)
        }
    }

    func navigateToUserView() {
        let userViewController = UserViewController()
        userViewController.coordinator = self
        navigationController.pushViewController(userViewController, animated: true)
    }
}

extension CoordinatorFlowController: UserCoordinator {
    func navigateToUserDataView() {
        let userDataViewController = UserDataViewController()
        userDataViewController.coordinator = self
        navigationController.pushViewController(userDataViewController, animated: true)
    }

    func navigateToSuggestionView() {
        let suggestionViewController = SuggestionViewController()
        suggestionViewController.coordinator = self
        navigationController.pushViewController(suggestionViewController, animated: true)
    }

    func navigateToLoginView() {
        let loginViewController = LoginViewController()
        loginViewController.coordinator = self
        navigationController.setViewControllers([loginViewController], animated: true)
    }
}
