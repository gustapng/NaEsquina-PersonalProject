//
//  NewPasswordCoordinator.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 20/11/24.
//

import Foundation
import UIKit

class NewPasswordCoordinator: Coordinator {
    private var navigationController: UINavigationController
    private var newPasswordViewController: NewPasswordViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        // Cria o NewPasswordViewController
        let newPasswordVC = NewPasswordViewController()
        newPasswordVC.coordinator = self // Atribui o coordenador ao VC
        self.newPasswordViewController = newPasswordVC
        
        // Empilha o controlador na pilha de navegação
        navigationController.pushViewController(newPasswordVC, animated: true)
    }

    func goToNextScreen() {
        // Lógica para navegação para a próxima tela
        let nextVC = NextScreenViewController() // Exemplo de próxima tela
        navigationController.pushViewController(nextVC, animated: true)
    }
}
