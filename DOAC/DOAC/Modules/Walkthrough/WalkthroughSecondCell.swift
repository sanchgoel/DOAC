//
//  WalkthroughSecondCell.swift
//  DOAC
//
//  Created by Sanchit Goel on 08/03/24.
//

import UIKit

class WalkthroughSecondCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    private let imageView = UIImageView()

    // Constants for layout and style
    private enum Layout {
        static let cornerRadius: CGFloat = 20
        static let borderWidth: CGFloat = 1
        static let borderColorHex = "#7C7C7C"
        static let titleTopMargin: CGFloat = 77
        static let textHorizontalPadding: CGFloat = 26
        static let descriptionTopMargin: CGFloat = 169
        static let titleFontSize: CGFloat = 34
        static let descriptionFontSize: CGFloat = 16
        static let lineHeightMultiple: CGFloat = 0.7
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        configureCell()
        configureImageView()
        configureTitleLabel()
        configureDescriptionLabel()
        setupConstraints()
    }

    private func configureCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = Layout.borderWidth
        contentView.layer.borderColor = UIColor(hex: Layout.borderColorHex)?.cgColor
        contentView.layer.cornerCurve = .continuous
        contentView.layer.cornerRadius = Layout.cornerRadius
    }

    private func configureImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "whiteGradient")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
    }

    private func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.text = "Beyond Small Talk, Diary-Style"
        titleLabel.numberOfLines = 0
        titleLabel.font = CustomFont.reenieBeanie.withSize(Layout.titleFontSize)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
    }

    private func configureDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = UIColor.black.withAlphaComponent(0.8)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = CustomFont.regular.withSize(Layout.descriptionFontSize)
        descriptionLabel.textAlignment = .center

        let text = "Immerse in authentic conversations using The Conversation Cards, featuring questions asked by accomplished guests from The Diary Of A CEO podcast."
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = Layout.lineHeightMultiple
        paragraphStyle.alignment = .center

        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: descriptionLabel.font
        ]
        
        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        descriptionLabel.attributedText = attributedString

        contentView.addSubview(descriptionLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.titleTopMargin),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.textHorizontalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.textHorizontalPadding),

            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.descriptionTopMargin),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.textHorizontalPadding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.textHorizontalPadding)
        ])
    }
}
