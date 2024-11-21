//
//  ConfirmEmailCoordinator.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 20/11/24.
//

import UIKit

class ConfirmEmailCoordinator: Coordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let confirmEmailViewController = ConfirmEmailViewController()
        confirmEmailViewController.coordinator = self // Passando o coordinator para o controller
        navigationController.pushViewController(confirmEmailViewController, animated: true)
    }

    // Função para navegar para outra tela, por exemplo, após a verificação do código
    func navigateToNextScreen() {
        // Aqui você pode adicionar a navegação para a próxima tela
        print("Navegando para a próxima tela após confirmação do código")
    }
}
