//
//  ImageCollectionViewCell.swift
//  SearchPhoto
//
//  Created by Slava Orlov on 08.03.2023.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {

    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = 4
        static let borderWidth: CGFloat = 1
    }

    // MARK: - Properties

    let imageView = UIImageView()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialState()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    // MARK: - Internal Methods

    func setupInitialState() {
        configureImageView()
    }

    func configure(urlImage: String) {
        imageView.downloadImage(from: urlImage)
    }

}

// MARK: - Private Methods

private extension ImageCollectionViewCell {

    func configureImageView() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = AssetColor.white
        self.layer.cornerRadius = Constants.cornerRadius
        self.layer.borderWidth = Constants.borderWidth
        self.layer.borderColor = AssetColor.grayBorder.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadius
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }

}
