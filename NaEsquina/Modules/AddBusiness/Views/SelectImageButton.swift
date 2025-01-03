//
//  SelectImageButton.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 24/10/24.
//

import UIKit

protocol ImagePickerViewDelegate: AnyObject {
    func didSelectImage(_ image: UIImage)
}

class SelectImageButton: UIButton, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Attributes

    weak var delegate: ImagePickerViewDelegate?

    // MARK: - UI Components

    private lazy var imagePickerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false

        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = ColorsExtension.lightGrayBackground
        config.baseForegroundColor = ColorsExtension.lightGray
        config.background.strokeColor = ColorsExtension.lightGray
        config.background.strokeWidth = 1.5
        config.background.cornerRadius = 9
        config.image = UIImage(systemName: "photo")
        config.imagePlacement = .leading
        config.imagePadding = 8

        let titleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)]
        config.attributedTitle = AttributedString("Selecionar Imagem", attributes: AttributeContainer(titleAttributes))

        button.configuration = config
        button.contentHorizontalAlignment = .leading
        button.addTarget(self, action: #selector(selectImage), for: .touchUpInside)

        return button
    }()

    // MARK: - Functions

    @objc private func selectImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary

        if let parentVC = parentViewController {
            parentVC.present(imagePickerController, animated: true, completion: nil)
        } else {
            print("Parent view controller não encontrado!")
        }
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            delegate?.didSelectImage(image)
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SelectImageButton: SetupView {
    func setup() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(imagePickerButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            imagePickerButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            imagePickerButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            imagePickerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while let responder = parentResponder {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            parentResponder = responder.next
        }
        return nil
    }
}
