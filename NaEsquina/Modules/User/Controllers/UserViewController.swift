//
//  UserViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 14/10/24.
//

import UIKit
import Firebase
import FirebaseAuth
import CoreData
import SwiftKeychainWrapper

class UserViewController: UIViewController {

    // MARK: - Coordinator

    var coordinator: CoordinatorFlowController?

    // MARK: - Attributes

    var auth: Auth?
    var context = CoreDataManager.shared.context

    // MARK: - UI Components

    private lazy var backButton: UIButton = .createCustomBackButton(target: self, action: #selector(backButtonTapped),
                                                                    borderColor: ColorsExtension.lightGray ?? .black)

    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        return label
    }()

    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        button.setTitle("Sair", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorsExtension.purpleMedium
        button.layer.cornerRadius = 9
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        button.layer.shadowColor = ColorsExtension.purpleLight?.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 0
        return button
    }()

    // MARK: - Functions

    @objc func backButtonTapped() {
        coordinator?.backToPreviousScreen()
    }

    @objc func logoutButtonTapped() {
        do {
            KeychainWrapper.standard.removeObject(forKey: "userEmail")
            KeychainWrapper.standard.removeObject(forKey: "userPassword")

            try self.auth?.signOut()

            deleteUserSettingsData()
            navigateToLoginView()
        } catch {
            print("Erro ao excluir UserSettings: \(error.localizedDescription)")
        }
    }

    private func deleteUserSettingsData() {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<UserSettings> = UserSettings.fetchRequest()

        do {
            let fetchedObjects = try context.fetch(fetchRequest)

            for object in fetchedObjects {
                context.delete(object)
            }

            try context.save()
            print("Dados de UserSettings excluídos com sucesso!")
        } catch {
            print("Erro ao excluir UserSettings: \(error.localizedDescription)")
        }
    }

    private func configureLabel() {
        if let displayName = Auth.auth().currentUser?.displayName {
            userNameLabel.text = "Olá, \(displayName)"
        } else {
            userNameLabel.text = "Olá, tudo bem?"
        }
    }

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureLabel()
    }
}

extension UserViewController: SetupView {
    func setup() {
        navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        self.auth = Auth.auth()
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(backButton)
        view.addSubview(userNameLabel)
        view.addSubview(logoutButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),

            userNameLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            userNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension UserViewController: UserCoordinator {
    func navigateToLoginView() {
        coordinator?.navigateToLoginView()
    }
}
