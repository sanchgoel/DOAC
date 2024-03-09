//
//  HomeViewController.swift
//  DOAC
//
//  Created by Sanchit Goel on 09/03/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    let titleLabel = UILabel()
    let scrollView = UIScrollView()
    let greetingLabel = UILabel()
    let suggestedLabel = UILabel()
    let statsLabel = UILabel()
    let containerView = UIView()
    let statsContainerView = UIView()
    var statsTitleLabels = [UILabel]()
    var statsValueLabels = [UILabel]()
    
    var statsSeeAllButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("See All", for: .normal)
        button.titleLabel?.font = CustomFont.semiBold.withSize(14)
        button.setTitleColor(UIColor(hex: "7C7C7C"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .right
        return button
    }()
    
    var conversationSeeAllButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("See All", for: .normal)
        button.titleLabel?.font = CustomFont.semiBold.withSize(14)
        button.setTitleColor(UIColor(hex: "7C7C7C"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .right
        return button
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 145, height: 190)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SuggestedConversationCell.self, forCellWithReuseIdentifier: "SuggestedConversationCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = .init(top: 0, left: 22, bottom: 0, right: 22)
        return collectionView
    }()
    
    var items = ["Mend Relationships",
                 "Coping with Grief & loss",
                 "Discrimination"]
    
    var statsText = ["Longest Session",
                     "Longest Conversation",
                     "Longest Streak",
                     "Longest ..."]

    var statsValueText = ["410 min",
                          "31 min",
                          "5 days",
                          "31 min"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
    }
    
    private func setupUI() {
        setupTitleLabel()
        setupScrollView()
        setupGreetingLabel()
        addQuickStartView()
        addCollectionView()
        addRecordStats()
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Home"
        titleLabel.textAlignment = .center
        titleLabel.font = CustomFont.bold.withSize(16)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 40, right: 0)
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 21),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupGreetingLabel() {
        greetingLabel.text = "Hello, Erin"
        greetingLabel.textAlignment = .left
        greetingLabel.numberOfLines = 0
        greetingLabel.font = CustomFont.bold.withSize(28)
        greetingLabel.textColor = .white
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
                
        scrollView.addSubview(greetingLabel)
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            greetingLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 22),
            greetingLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -22),
        ])
    }
    
    private func addQuickStartView() {
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor(hex: "#7C7C7C")?.cgColor
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = .clear
        containerView.alpha = 1.0
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(containerView)

        // Set constraints for the containerView
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 40),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 48)
        ])

        // Create and configure the title label
        let quickStartTitleLabel = UILabel()
        quickStartTitleLabel.text = "Quick Start a Conversation"
        quickStartTitleLabel.font = CustomFont.semiBold.withSize(18)
        quickStartTitleLabel.textColor = .white
        quickStartTitleLabel.textAlignment = .left

        // Create and configure the description label
        let quickStartDescLabel = UILabel()
        let text = "Start a conversation with random conversation cards"
        
        // Define the font and paragraph style
        let font = CustomFont.regular.withSize(14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.7
        
        // Create the attributed string
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        
        quickStartDescLabel.attributedText = attributedString
        
        quickStartDescLabel.textColor = .white.withAlphaComponent(0.8)
        quickStartDescLabel.textAlignment = .left
        quickStartDescLabel.numberOfLines = 0
        
        let imageView = UIImageView(image: UIImage(named: "forward-arrow"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        // Add labels to the containerView
        containerView.addSubview(quickStartTitleLabel)
        containerView.addSubview(quickStartDescLabel)
        containerView.addSubview(imageView)

        quickStartTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        quickStartDescLabel.translatesAutoresizingMaskIntoConstraints = false

        // Set constraints for the labels
        NSLayoutConstraint.activate([
            quickStartTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            quickStartTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
            quickStartTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -68),
            quickStartDescLabel.topAnchor.constraint(equalTo: quickStartTitleLabel.bottomAnchor, constant: 4),
            quickStartDescLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
            quickStartDescLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -68),
            quickStartDescLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func addCollectionView() {
        suggestedLabel.text = "Conversations suggested for you"
        suggestedLabel.textAlignment = .left
        suggestedLabel.numberOfLines = 0
        suggestedLabel.font = CustomFont.bold.withSize(18)
        suggestedLabel.textColor = .white
        suggestedLabel.translatesAutoresizingMaskIntoConstraints = false
                
        scrollView.addSubview(suggestedLabel)
        
        scrollView.addSubview(conversationSeeAllButton)
        
        collectionView.dataSource = self
        scrollView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            suggestedLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 40),
            suggestedLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 22),
            suggestedLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -22),
            conversationSeeAllButton.centerYAnchor.constraint(equalTo: suggestedLabel.centerYAnchor),
            conversationSeeAllButton.widthAnchor.constraint(equalToConstant: 41),
            conversationSeeAllButton.heightAnchor.constraint(equalToConstant: 40),
            conversationSeeAllButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -22),
            collectionView.topAnchor.constraint(equalTo: suggestedLabel.bottomAnchor, constant: 18),
            collectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 190)
        ])
    }
    
    func addRecordStats() {
        statsLabel.text = "Your Record Stats"
        statsLabel.textAlignment = .left
        statsLabel.numberOfLines = 0
        statsLabel.font = CustomFont.bold.withSize(18)
        statsLabel.textColor = .white
        statsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(statsLabel)
        
        statsContainerView.layer.borderWidth = 1.0
        statsContainerView.layer.borderColor = UIColor(hex: "#7C7C7C")?.cgColor
        statsContainerView.layer.cornerRadius = 8
        statsContainerView.backgroundColor = .clear
        statsContainerView.alpha = 1.0
        statsContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(statsContainerView)
        
        scrollView.addSubview(statsSeeAllButton)

        // Set constraints for the containerView
        NSLayoutConstraint.activate([
            statsLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
            statsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 22),
            statsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -22),
            statsSeeAllButton.centerYAnchor.constraint(equalTo: statsLabel.centerYAnchor),
            statsSeeAllButton.widthAnchor.constraint(equalToConstant: 41),
            statsSeeAllButton.heightAnchor.constraint(equalToConstant: 40),
            statsSeeAllButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -22),
            statsContainerView.topAnchor.constraint(equalTo: statsLabel.bottomAnchor, constant: 8),
            statsContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 22),
            statsContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -22),
            statsContainerView.heightAnchor.constraint(equalToConstant: 150),
            statsContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
        ])
        
        for index in 0..<4 {
            let statsTitleLabel = UILabel()
            statsTitleLabel.textAlignment = .left
            statsTitleLabel.textColor = UIColor(hex: "#7C7C7C")
            statsTitleLabel.font = CustomFont.medium.withSize(14)
            statsTitleLabel.text = statsText[index]
            statsContainerView.addSubview(statsTitleLabel)
            statsTitleLabels.append(statsTitleLabel)
            
            let statsValueLabel = UILabel()
            statsValueLabel.textAlignment = .right
            statsValueLabel.textColor = .white
            statsValueLabel.font = CustomFont.bold.withSize(18)
            statsValueLabel.text = statsValueText[index]
            statsContainerView.addSubview(statsValueLabel)
            statsValueLabels.append(statsValueLabel)
        }
        
        // Set constraints for labels
        for i in 0..<statsText.count {
            let sTitleLabel = statsTitleLabels[i]
            let sValueLabel = statsValueLabels[i]
            
            sTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            sValueLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                sTitleLabel.topAnchor.constraint(equalTo: i == 0 ? statsContainerView.topAnchor : statsTitleLabels[i - 1].bottomAnchor, constant: i == 0 ? 18: 6),
                sTitleLabel.leadingAnchor.constraint(equalTo: statsContainerView.leadingAnchor, constant: 16),
                sValueLabel.topAnchor.constraint(equalTo: sTitleLabel.topAnchor),
                sValueLabel.trailingAnchor.constraint(equalTo: statsContainerView.trailingAnchor, constant: -16),
            ])
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedConversationCell", for: indexPath) as! SuggestedConversationCell
        cell.configureTitle(text: items[indexPath.row].uppercased())
        return cell
    }
}
