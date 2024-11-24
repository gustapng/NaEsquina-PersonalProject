import UIKit

class UserOptionButtonCell: UITableViewCell {

    // MARK: - UI Components

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = ColorsExtension.lightGray
        return label
    }()

    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        return stackView
    }()

    private lazy var optionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    func configureCell(icon: UIImage?, title: String, subtitle: String, target: Any?, action: Selector, index: Int) {
        iconImageView.image = icon
        titleLabel.text = title
        subtitleLabel.text = subtitle
        optionButton.tag = index
        optionButton.addTarget(target, action: action, for: .touchUpInside)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        optionButton.removeTarget(nil, action: nil, for: .allEvents)
    }
}

extension UserOptionButtonCell: SetupView {
    func setup() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(textStackView)
        contentView.addSubview(optionButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.widthAnchor.constraint(equalToConstant: 25),
            iconImageView.heightAnchor.constraint(equalToConstant: 25),

            textStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textStackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            optionButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            optionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            optionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            optionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
