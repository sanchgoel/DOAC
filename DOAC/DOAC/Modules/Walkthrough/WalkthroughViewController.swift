//
//  WalkthroughViewController.swift
//  DOAC
//
//  Created by Sanchit Goel on 08/03/24.
//

import UIKit

class WalkthroughViewController: UIViewController {
    
    // MARK: - Properties
    private var collectionView: UICollectionView!
    private var pageControl: UIPageControl!
    private let titleLabel = UILabel()
    private var currentPage = 0
    private let totalCards = 4
    private var isInitialLoad = true
    
    // Constraints for dynamic UI updates
    private var nextButtonWidthConstraint: NSLayoutConstraint!
    private var nextButtonBottomConstraint: NSLayoutConstraint!
    private var pageControlTopConstraint: NSLayoutConstraint!
    
    // Data for the walkthrough
    private let walkthroughTitle = ["Beyond Small Talk, Diary-Style",
                                    "Prologue to Impact",
                                    "Embrace Shared Journeys"]
    private let walkthroughDesc = [
        "Immerse in authentic conversations using The Conversation Cards, featuring questions asked by accomplished guests from The Diary Of A CEO podcast.",
        "Explore wisdom and experiences, turning each interaction into a heartfelt journey.",
        "From cherished friends to newfound connections, The Conversation Cards unfold meaningful dialogues that deepen bonds and illuminate shared journeys in any setting."
    ]
    
    // MARK: - UI Elements
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 25
        button.alpha = 0.0
        button.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isInitialLoad {
            isInitialLoad = false
            animateFirstCell()
        }
    }
    
    // MARK: - Setup UI Methods
    private func setupUI() {
        setupCollection()
        setupPageControl()
        setupTitleLabel()
        setupButtons()
        setupConstraints()
    }
    
    private func setupCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width - 88, height: 415)
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 44)
        collectionView.decelerationRate = .fast
        collectionView.clipsToBounds = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WalkthroughFirstCell.self, forCellWithReuseIdentifier: "WalkthroughFirstCell")
        collectionView.register(WalkthroughSecondCell.self, forCellWithReuseIdentifier: "WalkthroughSecondCell")
        view.addSubview(collectionView)
    }
    
    private func setupPageControl() {
        pageControl = UIPageControl()
        pageControl.numberOfPages = totalCards
        pageControl.currentPage = 0
        pageControl.alpha = 0.0
        pageControl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "DOAC Conversation Cards"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
    }
    
    private func setupButtons() {
        view.addSubview(nextButton)
        view.addSubview(skipButton)
    }
    
    private func setupConstraints() {
        nextButtonWidthConstraint = nextButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 163)
        nextButtonBottomConstraint = nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        
        pageControlTopConstraint = pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 85)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButtonWidthConstraint,
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButtonBottomConstraint,
            skipButton.heightAnchor.constraint(equalToConstant: 40),
            skipButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -12),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 415),
            pageControlTopConstraint,
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc private func pageControlChanged(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func nextTapped() {
        let nextPage = pageControl.currentPage + 1
        
        if nextPage >= totalCards {
            completeWalkthrough()
        } else {
            proceedToNextPage(nextPage)
        }
    }
    
    @objc private func skipTapped() {
        proceedToLogin()
    }
    
    // MARK: - Helper Methods
    private func proceedToNextPage(_ page: Int) {
        pageControl.currentPage = page
        collectionView.scrollToItem(at: IndexPath(item: page, section: 0), at: .centeredHorizontally, animated: true)
        updateNextButton(for: page)
    }
    
    private func completeWalkthrough() {
        pageControl.currentPage = totalCards - 1
        updateNextButton(for: totalCards - 1)
        proceedToLogin()
    }
    
    private func updateNextButton(for page: Int) {
        let title = page == totalCards - 1 ? "Start My Journey" : "Next"
        nextButton.setTitle(title, for: .normal)
        nextButtonWidthConstraint.constant = page == totalCards - 1 ? 182 : 163
        skipButton.isHidden = page == 0
        view.layoutIfNeeded()
    }
    
    private func proceedToLogin() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    private func animateFirstCell() {
        guard let firstCell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)),
              let secondCell = collectionView.cellForItem(at: IndexPath(item: 1, section: 0)) else {
            return
        }
        
        firstCell.transform = CGAffineTransform(translationX: collectionView.bounds.width / 4, y: 0)
            .rotated(by: 3 * .pi / 180)
        firstCell.alpha = 0.5
        secondCell.alpha = 0
        
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            firstCell.transform = .identity
            firstCell.alpha = 1.0
            secondCell.alpha = 0.8
        })
        
        UIView.animate(withDuration: 0.3, delay: 0.4, options: .curveEaseInOut, animations: {
            self.nextButtonBottomConstraint.constant = -50
            self.nextButton.alpha = 1.0
            self.pageControlTopConstraint.constant = 55
            self.pageControl.alpha = 1.0
            self.view.layoutIfNeeded()
        })
    }
    
    private func updateCellTransformAndOpacity(_ cell: UICollectionViewCell, collectionView: UICollectionView) {
        // Delay the layout to ensure collection view's bounds are set
        DispatchQueue.main.async {
            let centerX = collectionView.contentOffset.x + collectionView.bounds.width / 2
            let baseRotationAngle: CGFloat = 3.0 // Degrees for rotation
            let offset = centerX - cell.center.x
            let maxOffset = collectionView.bounds.size.width / 2
            let angle = -baseRotationAngle * offset / maxOffset
            
            let radians = angle * .pi / 180
            
            // Calculate y-axis translation
            let baseTranslationY: CGFloat = 10 // Maximum translation in y (adjust as needed)
            let translationY = abs(offset) / maxOffset * baseTranslationY
            
            // Combine rotation and y-axis translation
            let transform = CGAffineTransform(rotationAngle: radians).translatedBy(x: 0, y: translationY)
            cell.transform = transform
            
            // Update zIndex for the cell based on its offset to center
            let distanceFromCenter = abs(offset)
            cell.layer.zPosition = -distanceFromCenter
            
            let minOpacity: CGFloat = 0.8 // Minimum opacity for cells not in the center
            let maxOpacityDifference = 1 - minOpacity
            let opacity = minOpacity + maxOpacityDifference * (1 - distanceFromCenter / maxOffset)
            cell.alpha = opacity
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, and UICollectionViewDelegateFlowLayout Implementation
extension WalkthroughViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalCards
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalkthroughFirstCell", for: indexPath) as! WalkthroughFirstCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalkthroughSecondCell", for: indexPath) as! WalkthroughSecondCell
            cell.titleLabel.text = walkthroughTitle[indexPath.row - 1]
            cell.descriptionLabel.text = walkthroughDesc[indexPath.row - 1]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        updateCellTransformAndOpacity(cell, collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 88, height: 415)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        centerCardInScrollView(scrollView, targetContentOffset: targetContentOffset)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateOnScrollEnd(scrollView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for cell in collectionView.visibleCells {
            updateCellTransformAndOpacity(cell, collectionView: collectionView)
        }
    }
    
    private func centerCardInScrollView(_ scrollView: UIScrollView, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
    private func updateOnScrollEnd(_ scrollView: UIScrollView) {
        let currentPage = Int((scrollView.contentOffset.x + scrollView.contentInset.left) / (scrollView.frame.width - 88))
        pageControl.currentPage = currentPage
        updateNextButton(for: currentPage)
    }
}
