//
//  UserViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 14/10/24.
//

import UIKit

class UserViewController: UIViewController {

    // MARK: - UI Components

    private lazy var backButton: UIButton = {
        return UIButton.createCustomBackButton(target: self, action: #selector(backButtonTapped), borderColor: ColorsExtension.lightGray ?? .black)
    }()

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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomUserOptionCell.self, forCellReuseIdentifier: "CustomUserOptionCell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.separatorColor = .lightGray
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Actions

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func goToUserDataView() {
        // TODO: CORRIGIR O QUE O BOTAO ESTA EXECUTANDO E MANDAR PARA A VIEW CONTROLLER CORRESPONDENTE
        print("DATA VIEW")
    }
}

extension UserViewController: SetupView {
    func setup() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(backButton)
        view.addSubview(userNameLabel)
        view.addSubview(tableView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),

            userNameLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            userNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            tableView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.UserOptions.options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomUserOptionCell", for: indexPath) as? CustomUserOptionCell else {
            return UITableViewCell()
        }

        cell.configureCell(icon: Constants.UserOptions.options[indexPath.row].icon,
                           title: Constants.UserOptions.options[indexPath.row].title,
                           subtitle: Constants.UserOptions.options[indexPath.row].subtitle,
                           target: self,
                           action: #selector(goToUserDataView))

        return cell
    }
}
