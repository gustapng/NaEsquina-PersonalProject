import UIKit

class FilterButtonCell: UICollectionViewCell {

    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.backgroundColor = ColorsExtension.purpleMedium
        button.layer.cornerRadius = 18
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with title: String) {
        filterButton.setTitle(title, for: .normal)
    }
    
    private func setup() {
        contentView.addSubview(filterButton)
        NSLayoutConstraint.activate([
            filterButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            filterButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            filterButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
