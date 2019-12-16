//
//  BindableSectionedCollectionViewSource.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

open class BindableSectionedCollectionViewSource<T> : NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: Fields

    public let collectionView: UICollectionView

    public let collectionFrame: SectionedCollectionFrame<T>

    public let cellIdentifier: String

    // MARK: Init
        
    convenience init(collectionView: UICollectionView, collectionFrame: SectionedCollectionFrame<T>) {
        self.init(collectionView: collectionView, collectionFrame: collectionFrame, cellIdentifier: "")
    }
    
    init(collectionView: UICollectionView, collectionFrame: SectionedCollectionFrame<T>, cellIdentifier: String) {
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

    open func getItemAt(_ indexPath: IndexPath) -> T {
        return getSectionAt(indexPath.section).items[indexPath.item]
    }

    open func getSectionAt(_ section: Int) -> Section<T> {
        return self.collectionFrame.itemsSource[section]
    }

    open func onItemsSourceChanged(_ oldItems: [Section<T>], _ newItems: [Section<T>]) {
        self.collectionView.reloadData()
    }

    open func getCellIdentifier(_ indexPath: IndexPath) -> String {
        return self.cellIdentifier
    }

    // MARK: UICollectionViewDataSource implementation

    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.collectionFrame.itemsSource.count
    }

    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getSectionAt(section).items.count
    }

    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: getCellIdentifier(indexPath), for: indexPath)
        if let bindable = cell as? BindableCollectionViewCell<T> {
            bindable.dataContext = getItemAt(indexPath)
        }
        return cell
    }

    // MARK: UICollectionViewDelegate implementation

    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let section = getSectionAt(indexPath.section)
        let item = getItemAt(indexPath)
        self.collectionFrame.onItemSelected(item: item, sectionType: section.type)
    }

    open func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    open func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }

    open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

    }

    // MARK: UICollectionViewDelegateFlowLayout implementation

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize ?? .zero
    }

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
    }

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0.0
    }

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 0.0
    }

}
