//
//  BindableCollectionViewSource.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

public class BindableCollectionViewSource<T> : NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: Fields

    let collectionView: UICollectionView

    let collectionFrame: CollectionFrame<T>

    let cellIdentifier: String

    // MARK: Init

    init(collectionView: UICollectionView, collectionFrame: CollectionFrame<T>, cellIdentifier: String) {
        self.collectionView = collectionView
        self.collectionFrame = collectionFrame
        self.cellIdentifier = cellIdentifier
        super.init()
        setupBindings()
    }

    // MARK: Private methods

    private func setupBindings() {
        self.collectionFrame.$itemsSource.bindAndFire(onItemsSourceChanged)
    }

    // MARK: Methods
    
    func getItemAt(_ indexPath: IndexPath) -> T {
        return self.collectionFrame.itemsSource[indexPath.row]
    }
    
    func onItemsSourceChanged(_ oldItems: [T], _ newItems: [T]) {
        self.collectionView.reloadData()
    }

    func getCellIdentifier(_ indexPath: IndexPath) -> String {
        return self.cellIdentifier
    }
    
    // MARK: UICollectionViewDataSource implementation

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionFrame.itemsSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: getCellIdentifier(indexPath), for: indexPath)
        if let bindable = cell as? BindableCollectionViewCell<T> {
            bindable.dataContext = getItemAt(indexPath)
        }
        return cell
    }

    // MARK: UICollectionViewDelegate implementation

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = getItemAt(indexPath)
        self.collectionFrame.onItemSelected(item: item)
    }

    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    // MARK: UICollectionViewDelegateFlowLayout implementation

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .zero
       }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

    }
    
}
