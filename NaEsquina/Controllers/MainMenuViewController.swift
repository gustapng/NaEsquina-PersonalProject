//
//  mainMenuViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 09/09/24.
//

import UIKit

class MainMenuViewController: UIViewController {

    // MARK: UI Components

    private lazy var backButton: UIButton = {
        return UIButton.createCustomBackButton(target: self, action: #selector(backButtonTapped),
                                               borderColor: ColorsExtension.lightGray ?? .black)
    }()
    
    private lazy var bottomBar: UITabBar = {
        let tabBar = UITabBar()
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.unselectedItemTintColor = ColorsExtension.purpleMedium
        tabBar.tintColor = ColorsExtension.purpleMedium
        tabBar.barTintColor = .white
        tabBar.delegate = self
        
        let homeItem = UITabBarItem(title: "Adicionar", image: UIImage(systemName: "plus.circle"), tag: 0)
        let filterItem = UITabBarItem(title: "Filtro", image: UIImage(systemName: "line.3.horizontal.decrease.circle"), tag: 1)
        let perfilItem = UITabBarItem(title: "Perfil", image: UIImage(systemName: "person"), tag: 2)

        tabBar.items = [homeItem, filterItem, perfilItem]
        return tabBar
    }()

    // MARK: Functions

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addBusiness() {
        let businessViewController = AddBusinessViewController()
        if let sheet = businessViewController.sheetPresentationController {
            sheet.detents = [.custom(resolver: { context in return 600 })]
            sheet.prefersGrabberVisible = true
        }
        present(businessViewController, animated: true, completion: nil)
    }

    @objc func openSheet() {
        let sheetViewController = FilterViewController()
        if let sheet = sheetViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        present(sheetViewController, animated: true, completion: nil)
    }

    @objc func goToOtherScreen() {
        let nextViewController = UIViewController()
        nextViewController.view.backgroundColor = .white
        nextViewController.title = "Outra Tela"
        navigationController?.pushViewController(nextViewController, animated: true)
    }

    // MARK: Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension MainMenuViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            addBusiness()
        case 1:
            openSheet()
        case 2:
            goToOtherScreen()
        default:
            break
        }
    }
}

extension MainMenuViewController: SetupView {
    func setup() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(backButton)
        view.addSubview(bottomBar)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),

            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
