import UIKit

class FilterButtonCell: UICollectionViewCell {

    // MARK: UI Components

    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.layer.cornerRadius = 18
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureButton(with title: String, isActive: Bool) {
        filterButton.setTitle(title, for: .normal)

        let backgroundColor = isActive ? ColorsExtension.purpleMedium : ColorsExtension.lightGray
        let titleColor = isActive ? UIColor.white : UIColor.black

        filterButton.backgroundColor = backgroundColor
        filterButton.setTitleColor(titleColor, for: .normal)
    }
}

extension FilterButtonCell: SetupView {
    func setup() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        contentView.addSubview(filterButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            filterButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            filterButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            filterButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
