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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(hex: "#7C7C7C")?.cgColor
        contentView.layer.cornerCurve = .continuous
        contentView.layer.cornerRadius = 20
        
        imageView.frame = contentView.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "whiteGradient")
        contentView.addSubview(imageView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.text = "Beyond Small Talk, Diary-Style"
        titleLabel.numberOfLines = 0
        titleLabel.font = CustomFont.reenieBeanie.withSize(34)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = UIColor.black.withAlphaComponent(0.8)
        descriptionLabel.numberOfLines = 0
        
        let text = "Immerse in authentic conversations using The Conversation Cards, featuring questions asked by accomplished guests from The Diary Of A CEO podcast."
        let attributedString = NSMutableAttributedString(string: text)
        
        // Set up paragraph style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.7
        paragraphStyle.alignment = .center
                
        let font = CustomFont.regular.withSize(16)
                
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: font
        ]
        
        // Apply attributes to the attributed string
        attributedString.addAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))
        
        // Assign the attributed string to the UILabel
        descriptionLabel.attributedText = attributedString
        contentView.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 77),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 26),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 169),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 26),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
