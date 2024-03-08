//
//  WalkthroughFirstCell.swift
//  DOAC
//
//  Created by Sanchit Goel on 08/03/24.
//

import UIKit

class WalkthroughFirstCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    private let descLabel = UILabel()
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .black
        layer.borderColor = UIColor(hex: "#7C7C7C")?.cgColor
        layer.cornerCurve = .continuous
        layer.borderWidth = 1.0
        layer.cornerRadius = 20

        imageView.frame = contentView.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "gradient")
        contentView.addSubview(imageView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.text = "THE DIARY OF A CEO"
        titleLabel.font = CustomFont.regular.withSize(28)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.textColor = .white
        descLabel.text = "CONVERSATION CARDS"
        descLabel.textAlignment = .center
        descLabel.font = CustomFont.bold.withSize(24)
        contentView.addSubview(descLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 176),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 210),
            descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
