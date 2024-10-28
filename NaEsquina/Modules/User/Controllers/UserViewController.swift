//
//  UserViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 14/10/24.
//

import UIKit

class UserViewController: UIViewController {

    // MARK: - UI Components

    private lazy var backButton: UIButton = .createCustomBackButton(target: self, action: #selector(backButtonTapped),
                                                                    borderColor: ColorsExtension.lightGray ?? .black)

    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        // TODO: O NOME DO USUARIO E DINAMICO
        label.text = "Nome do usuário"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        return label
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserOptionButtonCell.self, forCellReuseIdentifier: "UserOptionButtonCell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.separatorColor = ColorsExtension.lightGray
        return tableView
    }()

    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false

        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "door.left.hand.open")
        config.title = "Sair"
        config.baseForegroundColor = ColorsExtension.lightGray
        config.imagePadding = 17
        config.imagePlacement = .leading

        button.configuration = config
        button.contentHorizontalAlignment = .leading
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)

        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableFooterView()
    }

    // MARK: - Actions

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func actionCell(sender: UIButton) {
        let index = sender.tag
        let action = Constants.UserOptions.options[index].action

        switch action {
        case "goToUserDataView":
            goToUserDataView()
        case "goToSuggestionView":
            goToSuggestionView()
        default:
            print("Ação desconhecida")
        }
    }

    @objc func goToUserDataView() {
        let userDataViewController = UserDataViewController()
        navigationController?.pushViewController(userDataViewController, animated: true)
    }

    @objc func goToSuggestionView() {
        let suggestionViewController = SuggestionViewController()
        navigationController?.pushViewController(suggestionViewController, animated: true)
    }

    @objc func logoutButtonTapped() {
        print("ACTION DE LOGOUT")
    }

    // MARK: - Function

    private func setupTableFooterView() {
        let footerView = UIView(frame: CGRect(x: 5, y: 0, width: view.frame.width, height: 70))
        footerView.addSubview(logoutButton)

        NSLayoutConstraint.activate([
            logoutButton.heightAnchor.constraint(equalToConstant: 70),
            logoutButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor),
            logoutButton.topAnchor.constraint(equalTo: footerView.topAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor)
        ])

        tableView.tableFooterView = footerView
    }
}

extension UserViewController: SetupView {
    func setup() {
        navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(backButton)
        view.addSubview(userNameLabel)
        view.addSubview(tableView)
        view.addSubview(logoutButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),

            userNameLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            userNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            tableView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.UserOptions.options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserOptionButtonCell", for: indexPath) as? UserOptionButtonCell else {
            return UITableViewCell()
        }

        let option = Constants.UserOptions.options[indexPath.row]
        cell.configureCell(icon: UIImage(systemName: option.icon),
                           title: option.title,
                           subtitle: option.subtitle,
                           target: self,
                           action: #selector(actionCell),
                           index: indexPath.row)

        cell.backgroundColor = .white

        return cell
    }
}
