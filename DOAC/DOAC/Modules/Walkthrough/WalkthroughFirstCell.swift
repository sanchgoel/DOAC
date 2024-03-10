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
    
    // Constants for layout and design
    private enum Constants {
        static let cornerRadius: CGFloat = 20
        static let borderWidth: CGFloat = 1
        static let titleTopOffset: CGFloat = 176
        static let descTopOffset: CGFloat = 210
        static let titleFontSize: CGFloat = 28
        static let descFontSize: CGFloat = 24
        static let borderColorHex = "#7C7C7C"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        // Configure content view
        contentView.layer.borderColor = UIColor(hex: Constants.borderColorHex)?.cgColor
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.layer.borderWidth = Constants.borderWidth
        contentView.clipsToBounds = true
        contentView.backgroundColor = .clear
        
        // Configure image view
        setupImageView()
        
        // Configure title label
        setupTitleLabel()
        
        // Configure description label
        setupDescriptionLabel()
        
        // Apply constraints
        applyConstraints()
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "gradient")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.text = "THE DIARY OF A CEO"
        titleLabel.font = CustomFont.regular.withSize(Constants.titleFontSize)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
    }
    
    private func setupDescriptionLabel() {
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.textColor = .white
        descLabel.text = "CONVERSATION CARDS"
        descLabel.font = CustomFont.bold.withSize(Constants.descFontSize)
        descLabel.textAlignment = .center
        contentView.addSubview(descLabel)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: Constants.titleTopOffset),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            descLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                           constant: Constants.descTopOffset),
            descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
