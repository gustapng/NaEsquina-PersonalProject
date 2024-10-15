import UIKit

class CustomUserOptionCell: UITableViewCell {

    private var optionButton: UIButton!

    func configureCell(icon: String,
                       title: String,
                       subtitle: String,
                       target: Any?,
                       action: Selector) {

        optionButton = UIButton(type: .system)

        let imageConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        let resizedImage = UIImage(systemName: icon, withConfiguration: imageConfig)

        var config = UIButton.Configuration.plain()
        config.image = resizedImage
        config.imagePadding = 10
        config.baseForegroundColor = .black
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ]

        let subtitleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: ColorsExtension.lightGray ?? UIColor.gray,
            .font: UIFont.systemFont(ofSize: 12, weight: .regular)
        ]

        let attributedTitle = NSMutableAttributedString(string: title, attributes: titleAttributes)
        let attributedSubtitle = NSAttributedString(string: "\n" + subtitle, attributes: subtitleAttributes)

        attributedTitle.append(attributedSubtitle)

        optionButton.setAttributedTitle(attributedTitle, for: .normal)
        optionButton.configuration = config
        optionButton.contentHorizontalAlignment = .left

        optionButton.addTarget(target, action: action, for: .touchUpInside)
        optionButton.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(optionButton)

        NSLayoutConstraint.activate([
            optionButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            optionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            optionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            optionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        optionButton.removeTarget(nil, action: nil, for: .allEvents)
    }
}
