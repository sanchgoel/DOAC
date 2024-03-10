//
//  GoalPreferencesViewController.swift
//  DOAC
//
//  Created by Sanchit Goel on 08/03/24.
//

import UIKit

class GoalPreferencesViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private var buttons = [UIButton]()
    private var customizeButtonBottomConstraint: NSLayoutConstraint!
    private var vStackTopConstraint: NSLayoutConstraint!
    
    private let goalPreferences = [
        "Meaningful connections",
        "Self-improvement",
        "Coping with grief & loss",
        "Coping with discrimination",
        "Conversation starters",
        "Mend relationships",
        "Up-keep relationships",
        "It’s something else"
    ]
    
    private lazy var customizeButton: UIButton = createCustomiseButton()
    private lazy var skipButton: UIButton = createSkipButton()
    private lazy var backButton: UIButton = createBackButton()
    
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
        addButtonsToStack()
    }
    
    func setupLabels() {
        titleLabel.text = "What are your goals?"
        titleLabel.textAlignment = .center
        titleLabel.font = CustomFont.bold.withSize(16)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let text = "Your answers won’t stop you from accessing any activities and you can change your settings later"
        
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
        view.addSubview(customizeButton)
        view.addSubview(skipButton)
        view.addSubview(backButton)
                
        customizeButtonBottomConstraint = customizeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
        
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
            customizeButton.heightAnchor.constraint(equalToConstant: 50),
            customizeButton.widthAnchor.constraint(equalToConstant: 229),
            customizeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customizeButtonBottomConstraint,
            skipButton.heightAnchor.constraint(equalToConstant: 40),
            skipButton.widthAnchor.constraint(equalToConstant: 80),
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skipButton.topAnchor.constraint(equalTo: customizeButton.bottomAnchor, constant: 0),
        ])
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = UIEdgeInsets(top: 42, left: 0, bottom: 42, right: 0)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: customizeButton.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupStackView() {
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alpha = 0
        
        vStackTopConstraint = stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50)
        NSLayoutConstraint.activate([
            vStackTopConstraint,
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -32),
            stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 64)
        ])
    }
    
    private func addButtonsToStack() {
        for index in 0...7 {
            let button = UIButton(type: .custom)
            button.setTitle(goalPreferences[index], for: .normal)
            button.titleLabel?.font = CustomFont.bold.withSize(18)
            button.setTitleColor(.white, for: .normal)
            button.setTitleColor(.black, for: .selected)
            button.backgroundColor = .black
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 1.0
            button.layer.cornerRadius = 25
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()  // Toggle the selected state
        
        if sender.isSelected {
            sender.backgroundColor = .white
            sender.layer.borderColor = UIColor.black.cgColor
        } else {
            sender.backgroundColor = .black
            sender.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    private func animateOptions() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseInOut, animations: {
            self.vStackTopConstraint.constant = 0
            self.customizeButtonBottomConstraint.constant = -25
            self.stackView.alpha = 1.0
            self.customizeButton.alpha = 1.0
            self.skipButton.alpha = 1.0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func customizeTapped() {
        proceedToSessionSettings()
    }
    
    @objc func skipTapped() {
        proceedToSessionSettings()
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func proceedToSessionSettings() {
        let sessionSettingsVC = SessionSettingsViewController()
        self.navigationController?.pushViewController(sessionSettingsVC,
                                                      animated: true)
    }
}

private extension GoalPreferencesViewController {
    func createCustomiseButton() -> UIButton {
        let button = UIButton(type: .custom)
        let text = "Customize my sessions"
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = CustomFont.bold.withSize(18)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(customizeTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        button.alpha = 0.0
        return button
    }

    func createSkipButton() -> UIButton {
        let button = UIButton(type: .custom)
        let text = "Skip"
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = CustomFont.bold.withSize(16)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .normal)
        button.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.0
        return button
    }

    func createBackButton() -> UIButton {
        let button = UIButton(type: .system)
        if let image = UIImage(named: "back") {
            button.setImage(image, for: .normal)
        }
        button.tintColor = UIColor.white
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
