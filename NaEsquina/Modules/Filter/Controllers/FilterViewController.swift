//
//  FilterViewController.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 18/09/24.
//

import UIKit

class FilterViewController: UIViewController {

    // MARK: UI Components

    private lazy var sheetInfoView: SheetInfoView = {
        let sheetInfoView = SheetInfoView(title: "Filtros",
                                          subtitle: "Selecione uma ou mais categorias para encontrar comércios específicos, como mercados, restaurantes e mais.")
        sheetInfoView.translatesAutoresizingMaskIntoConstraints = false
        return sheetInfoView
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(FilterButtonCell.self, forCellWithReuseIdentifier: "FilterButtonCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    // MARK: Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension FilterViewController: SetupView {
    func setup() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(sheetInfoView)
        view.addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            sheetInfoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 42),
            sheetInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sheetInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            collectionView.topAnchor.constraint(equalTo: sheetInfoView.topAnchor, constant: 120),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FilterViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterButtonCell", for: indexPath) as! FilterButtonCell
        cell.configureButton(with: filters[indexPath.item].name, isActive: filters[indexPath.item].isActive)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let padding: CGFloat = 10
        let availableWidth = collectionView.frame.width - padding
        let buttonSize = (availableWidth - 10) / 2
        return CGSize(width: buttonSize, height: 35)
    }
}
