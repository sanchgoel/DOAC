//
//  WalkthroughViewController.swift
//  DOAC
//
//  Created by Sanchit Goel on 08/03/24.
//

import UIKit

class WalkthroughViewController: UIViewController {

    var collectionView: UICollectionView!
    var pageControl: UIPageControl!
    var titleLabel = UILabel()
    var currentPage = 0
    let totalCards = 4
    private var isInitialLoad = true
    var nextButtonWidthConstraint: NSLayoutConstraint!
    
    let walkthroughTitle = ["Beyond Small Talk, Diary-Style",
                            "Prologue to Impact",
                            "Embrace Shared Journeys"]
    let walkthroughDesc = ["Immerse in authentic conversations using The Conversation Cards, featuring questions asked by accomplished guests from The Diary Of A CEO podcast.",
                            "Explore wisdom and experiences, turning each interaction into a heartfelt journey.",
                            "From cherished friends to newfound connections, The Conversation Cards unfold meaningful dialogues that deepen bonds and illuminate shared journeys in any setting."]
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        let projectText = "Next"
        button.setTitle(projectText, for: .normal)
        button.titleLabel?.font = CustomFont.bold.withSize(18)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Perform the initial animation for the first cell
        if isInitialLoad {
            isInitialLoad = false  // Ensure animation runs only once
            animateFirstCell()
        }
    }
    
    func setupUI() {
        setupCollection()
        setupPageControl()
        
        titleLabel.text = "DOAC Conversation Cards"
        titleLabel.textAlignment = .center
        titleLabel.font = CustomFont.bold.withSize(16)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleLabel)
        
        self.view.addSubview(nextButton)
        
        nextButtonWidthConstraint = nextButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 163)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButtonWidthConstraint,
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -12),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 415)
        ])
    }
    
    func setupCollection() {
        // Layout setup
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width - 88, height: 415)
        layout.minimumLineSpacing = 10
        
        // Collection view setup
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CardCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 44)
        collectionView.decelerationRate = .fast
        collectionView.clipsToBounds = false
        
        collectionView.register(WalkthroughFirstCell.self,
                                forCellWithReuseIdentifier: "WalkthroughFirstCell")
        collectionView.register(WalkthroughSecondCell.self,
                                forCellWithReuseIdentifier: "WalkthroughSecondCell")
        
        // Add collection view to the view controller's view
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
    }
    
    private func setupPageControl() {
        pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
        view.addSubview(pageControl)
        
        // Constraints for pageControl...
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 55),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func pageControlChanged(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func updateCellTransformAndOpacity(_ cell: UICollectionViewCell, collectionView: UICollectionView) {
        // Delay the layout to ensure collection view's bounds are set
        DispatchQueue.main.async {
            let centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.width / 2
            let baseRotationAngle: CGFloat = 3.0 // Degrees for rotation
            let offset = centerX - cell.center.x
            let maxOffset = self.collectionView.bounds.size.width / 2
            let angle = -baseRotationAngle * offset / maxOffset
            
            let radians = angle * .pi / 180
            cell.transform = CGAffineTransform(rotationAngle: radians)

            // Update zIndex for the cell based on its offset to center
            let distanceFromCenter = abs(offset)
            cell.layer.zPosition = -distanceFromCenter
            
            let minOpacity: CGFloat = 0.8 // Minimum opacity for cells not in the center
            let maxOpacityDifference = 1 - minOpacity
            let opacity = minOpacity + maxOpacityDifference * (1 - distanceFromCenter / maxOffset)
            cell.alpha = opacity
        }
    }
    
    private func animateFirstCell() {
        guard let firstCell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)),
        let secondCell = collectionView.cellForItem(at: IndexPath(item: 1, section: 0))else {
            return
        }
        
        // Set initial state for animation (off-screen)
        firstCell.transform = CGAffineTransform(translationX: collectionView.bounds.width/4, y: 0)
            .rotated(by: 3 * .pi / 180)
        firstCell.alpha = 0.5
        secondCell.alpha = 0.0
        
        // Animate to final state (current position)
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            firstCell.transform = CGAffineTransform.identity
            firstCell.alpha = 1.0
            secondCell.alpha = 0.8
        }, completion: nil)
    }
    
    @objc func nextTapped() {
        let nextPage = pageControl.currentPage + 1
        
        if nextPage >= totalCards {
            pageControl.currentPage = totalCards - 1  // Stay on the last card
            nextButton.setTitle("Start My Journey", for: .normal)
            nextButtonWidthConstraint.constant = 182
        } else {
            pageControl.currentPage = nextPage
            collectionView.scrollToItem(at: IndexPath(item: nextPage, section: 0), at: .centeredHorizontally, animated: true)
            if nextPage == totalCards - 1 {
                nextButton.setTitle("Start My Journey", for: .normal)
                nextButtonWidthConstraint.constant = 182
            } else {
                nextButton.setTitle("Next", for: .normal)
                nextButtonWidthConstraint.constant = 163
            }
        }
        self.view.layoutIfNeeded()
    }
}

extension WalkthroughViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
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
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 88, height: 415)
    }
    
    // Implementing UIScrollViewDelegate method to center the card
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
        let pageWidth = scrollView.frame.size.width - 88
        let currentPage = Int((targetContentOffset.pointee.x + scrollView.contentInset.left) / pageWidth)
        pageControl.currentPage = currentPage
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int((scrollView.contentOffset.x + scrollView.contentInset.left) / (scrollView.frame.width - 88))
        pageControl.currentPage = currentPage
        
        if currentPage == totalCards - 1 {
            nextButton.setTitle("Start My Journey", for: .normal)
            nextButtonWidthConstraint.constant = 182
        } else {
            nextButton.setTitle("Next", for: .normal)
            nextButtonWidthConstraint.constant = 163
        }
        self.view.layoutIfNeeded()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for cell in collectionView.visibleCells {
            updateCellTransformAndOpacity(cell, collectionView: collectionView)
        }
    }
}
