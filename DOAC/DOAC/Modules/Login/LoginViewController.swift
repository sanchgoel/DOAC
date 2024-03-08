//
//  LoginViewController.swift
//  DOAC
//
//  Created by Sanchit Goel on 08/03/24.
//

import UIKit

class LoginViewController: UIViewController {

    let titleLabel = UILabel()
    let stackView = UIStackView()
    var titleTopConstraint: NSLayoutConstraint!
    
    lazy var skipButton: UIButton = {
        let button = UIButton(type: .custom)
        let projectText = "Skip"
        button.setTitle(projectText, for: .normal)
        button.titleLabel?.font = CustomFont.bold.withSize(16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.0
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        setupTitleLabel()
        setupStackView()
        setupLoginOptions()
        animateOptions()
    }

    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.alpha = 0.0
        let text = "Create an account or sign in to save and see your conversation history"
        
        // Define the font and paragraph style
        let font = CustomFont.bold.withSize(28)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.7
        
        // Create the attributed string
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        
        titleLabel.attributedText = attributedString
        
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        self.view.addSubview(skipButton)

        titleTopConstraint = titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 322)
        NSLayoutConstraint.activate([
            titleTopConstraint,
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            skipButton.heightAnchor.constraint(equalToConstant: 40),
            skipButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -71)
        ])
    }
    
    private func animateOptions() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseInOut, animations: {
            self.titleTopConstraint.constant = 282
            self.stackView.alpha = 1.0
            self.titleLabel.alpha = 1.0
            self.skipButton.alpha = 1.0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.alpha = 0.0
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 46),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -46),
            stackView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func setupLoginOptions() {
        let loginOptions = [("Google", "google"), ("Apple", "apple"), ("Facebook", "facebook")]
        
        for (title, imageName) in loginOptions {
            let loginView = createLoginView(with: title, imageName: imageName)
            stackView.addArrangedSubview(loginView)
            
            // Add constraints if needed, e.g., set height
            loginView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        }
    }
    
    private func createLoginView(with title: String, imageName: String) -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        
        let imageView = UIImageView(image: UIImage(named: imageName))
        let label = UILabel()
        label.font = CustomFont.bold.withSize(18)
        label.text = "Continue with \(title)"
        
        imageView.contentMode = .scaleAspectFit
        label.textAlignment = .center
        
        view.addSubview(imageView)
        view.addSubview(label)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Add tap gesture or button for action
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLoginTap(_:)))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        
        return view
    }
    
    @objc private func handleLoginTap(_ sender: UITapGestureRecognizer) {
        // Determine which view was tapped and handle accordingly
        if let view = sender.view {
            // Here you can differentiate based on view or use the view's tag property if set
            print("Login view tapped")
        }
    }
    
    @objc func skipTapped() {
        let preferencesVC = GoalPreferencesViewController()
        self.navigationController?.pushViewController(preferencesVC,
                                                      animated: true)
    }
}
