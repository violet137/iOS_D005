//
//  PagingCollectionView.swift
//  OrderNow
//
//  Created by ADMIN on 9/13/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//  Source : https://medium.com/@shaibalassiano/tutorial-horizontal-uicollectionview-with-paging-9421b479ee94

import UIKit

protocol PagingCollectionViewDelegate {
    
    func pagingCollectionView(_ pagingCollectionView: PagingCollectionView, cellForItemAt indexPath: IndexPath, dataCell data: AnyObject) -> UICollectionViewCell
}

class PagingCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    public var source = [AnyObject]() { didSet { reloadData() }}

    public var delegateView : PagingCollectionViewDelegate!
    private var collectionViewFlowLayout : UICollectionViewFlowLayout!
    private var indexOfCellBeforeDragging = 0

    // Init methods..
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        collectionViewFlowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout
        collectionViewFlowLayout.minimumLineSpacing = 0
        
        self.dataSource = self
        self.delegate = self
        collectionViewFlowLayout.scrollDirection = .horizontal
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureCollectionViewLayoutItemSize()
    }

    private func calculateSectionInset() -> CGFloat {
        let deviceIsIpad = UIDevice.current.userInterfaceIdiom == .pad
        let deviceOrientationIsLandscape = UIDevice.current.orientation.isLandscape
        let cellBodyViewIsExpended = deviceIsIpad || deviceOrientationIsLandscape
        let cellBodyWidth: CGFloat = 236 + (cellBodyViewIsExpended ? 174 : 0)

        let buttonWidth: CGFloat = 50

        let inset = (collectionViewLayout.collectionView!.frame.width - cellBodyWidth + buttonWidth) / 4
        return inset
    }

    private func configureCollectionViewLayoutItemSize() {
        let inset: CGFloat = calculateSectionInset() // This inset calculation is some magic so the next and the previous cells will peek from the sides. Don't worry about it
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)

        collectionViewFlowLayout.itemSize = CGSize(width: collectionViewLayout.collectionView!.frame.size.width - inset * 2, height: collectionViewLayout.collectionView!.frame.size.height)
    }

    private func indexOfMajorCell() -> Int {
        let itemWidth = collectionViewFlowLayout.itemSize.width
        let proportionalOffset = collectionViewLayout.collectionView!.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(source.count - 1, index))
        return safeIndex
    }
    
    // ===================================
    // MARK: - UICollectionViewDataSource:
    // ===================================
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return source.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return delegateView.pagingCollectionView(self, cellForItemAt: indexPath ,dataCell: source[indexPath.count])
    }
    
    // =================================
    // MARK: - UICollectionViewDelegate:
    // =================================
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfMajorCell()
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Stop scrollView sliding:
        targetContentOffset.pointee = scrollView.contentOffset

        // calculate where scrollView should snap to:
        let indexOfMajorCell = self.indexOfMajorCell()

        // calculate conditions:
        let swipeVelocityThreshold: CGFloat = 0.5 // after some trail and error
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < source.count && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)

        if didUseSwipeToSkipCell {

            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = collectionViewFlowLayout.itemSize.width * CGFloat(snapToIndex)

            // Damping equal 1 => no oscillations => decay animation:
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: nil)

        } else {
            // This is a much better way to scroll to a cell:
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
