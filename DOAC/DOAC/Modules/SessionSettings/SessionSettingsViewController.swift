//
//  SessionSettingsViewController.swift
//  DOAC
//
//  Created by Sanchit Goel on 08/03/24.
//

import UIKit

class SessionSettingsViewController: UIViewController {
    
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    var saveButtonBottomConstraint: NSLayoutConstraint!
    var vStackTopConstraint: NSLayoutConstraint!
    
    var settingsText = ["Set background music",
                        "Volume",
                        "Record our session",
                        "Show conversation duration",
                        "Dim screen after 5 minutes of conversation"]
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .custom)
        let projectText = "Save Customization"
        button.setTitle(projectText, for: .normal)
        button.titleLabel?.font = CustomFont.bold.withSize(18)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        button.alpha = 0.0
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        if let image = UIImage(named: "back") {
            button.setImage(image, for: .normal)
        }
        button.tintColor = UIColor.white
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        setupUI()
        animateOptions()
    }
    
    func setupUI() {
        setupLabels()
        setupScrollView()
        setupStackView()
        addSubviewsAndSeparators()
    }
    
    func setupLabels() {
        titleLabel.text = "Customize your sessions"
        titleLabel.textAlignment = .center
        titleLabel.font = CustomFont.bold.withSize(16)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let text = "You can update your customizations in settings"
        
        // Define the font and paragraph style
        let font = CustomFont.regular.withSize(16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.7
        
        // Create the attributed string
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        
        subTitleLabel.attributedText = attributedString
        subTitleLabel.textAlignment = .center
        subTitleLabel.numberOfLines = 0
        subTitleLabel.textColor = .white.withAlphaComponent(0.8)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(saveButton)
        view.addSubview(backButton)
        
        saveButtonBottomConstraint = saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 42),
            subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            subTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 229),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButtonBottomConstraint
        ])
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 61),
            scrollView.bottomAnchor.constraint(equalTo: saveButton.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupStackView() {
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 1  // for the separator views
        stackView.alpha = 0
        
        vStackTopConstraint = stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40)
        NSLayoutConstraint.activate([
            vStackTopConstraint,
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 48)
        ])
    }
    
    private func addSubviewsAndSeparators() {
        for index in 0..<5 {
            let view = UIView()
            view.backgroundColor = .clear
            
            let label = UILabel()
            label.text = settingsText[index]
            label.textColor = .white
            label.font = CustomFont.medium.withSize(14)
            label.textAlignment = .left
            label.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(label)
            
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 72),
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                label.topAnchor.constraint(equalTo: view.topAnchor),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor)
            ])
            
            stackView.addArrangedSubview(view)
            
            if index < 4 {
                let separator = UIView()
                separator.backgroundColor = .white.withAlphaComponent(0.5)
                separator.translatesAutoresizingMaskIntoConstraints = false
                stackView.addArrangedSubview(separator)
                                
                separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
            }
                        
            switch index {
            case 2,3,4:
                let toggle = UISwitch()
                view.addSubview(toggle)
                toggle.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    toggle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                    toggle.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])
                
            case 1:
                let slider = UISlider()
                slider.minimumTrackTintColor = .white
                view.addSubview(slider)
                slider.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                    slider.widthAnchor.constraint(equalToConstant: 132),
                    slider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                ])
                
            case 0:
                let detailLabel = UILabel()
                detailLabel.text = "jazz"
                detailLabel.textColor = .white
                detailLabel.font = CustomFont.bold.withSize(18)
                let imageView = UIImageView(image: UIImage(named: "arrow-down"))
                imageView.contentMode = .scaleAspectFit
                
                view.addSubview(detailLabel)
                view.addSubview(imageView)
                
                detailLabel.translatesAutoresizingMaskIntoConstraints = false
                imageView.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    imageView.widthAnchor.constraint(equalToConstant: 24),
                    imageView.heightAnchor.constraint(equalToConstant: 24),
                    detailLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -10),
                    detailLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])
                
            default:
                break
            }
        }
    }
    
    private func animateOptions() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseInOut, animations: {
            self.vStackTopConstraint.constant = 0
            self.saveButtonBottomConstraint.constant = -25
            self.stackView.alpha = 1.0
            self.saveButton.alpha = 1.0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveTapped() {
        
    }
}
