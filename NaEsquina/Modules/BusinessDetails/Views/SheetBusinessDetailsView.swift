
//
//  SheetBusinessDetailsView.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 01/10/24.
//

import UIKit
import RxSwift
import RxCocoa

class SheetBusinessDetailsView: UIView {

    // MARK: - Attributes
    
    private let loadingSubject = BehaviorSubject<Bool>(value: false)
    private let disposeBag = DisposeBag()

    // MARK: - UI Components

    private lazy var businessImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var viewTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .semibold)
        label.textColor = ColorsExtension.purpleLight
        return label
    }()

    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = ColorsExtension.lightGray
        label.numberOfLines = 0
        return label
    }()

    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = ColorsExtension.lightGray
        label.numberOfLines = 0
        return label
    }()

    private lazy var loadingView: LoadingView = {
        let loading = LoadingView()
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()

    // MARK: - Functions

    func configure(with data: BusinessLocationFirebaseResponse) {
        // TODO - fix report button and finish project
        self.businessImageView.image = data.image ?? UIImage(named: "comercio")
        self.viewTitleLabel.text = data.name
        self.addressLabel.text = data.address
        self.phoneLabel.text = data.phone
    }

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SheetBusinessDetailsView: SetupView {
    func setup() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(businessImageView)
        addSubview(viewTitleLabel)
        addSubview(addressLabel)
        addSubview(phoneLabel)
        addSubview(loadingView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            businessImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            businessImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            businessImageView.heightAnchor.constraint(equalToConstant: 200),
            businessImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            businessImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            viewTitleLabel.topAnchor.constraint(equalTo: businessImageView.bottomAnchor, constant: 16),
            viewTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            addressLabel.topAnchor.constraint(equalTo: viewTitleLabel.bottomAnchor, constant: 6),
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            phoneLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 6),
            phoneLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            loadingView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 90),
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.widthAnchor.constraint(equalToConstant: 120),
            loadingView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
