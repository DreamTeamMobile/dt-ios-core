//
//  BindableSectionedCollectionViewSource.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

public class BindableSectionedCollectionViewSource<T> : NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: Fields

    let collectionView: UICollectionView

    let collectionFrame: SectionedCollectionFrame<T>

    let cellIdentifier: String

    // MARK: Init

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

    func getItemAt(_ indexPath: IndexPath) -> T {
        return getSectionAt(indexPath.section).items[indexPath.item]
    }

    func getSectionAt(_ section: Int) -> Section<T> {
        return self.collectionFrame.itemsSource[section]
    }

    // MARK: Methods

    func onItemsSourceChanged(_ oldItems: [Section<T>], _ newItems: [Section<T>]) {
        self.collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource implementation

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.collectionFrame.itemsSource.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getSectionAt(section).items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath)
        if let bindable = cell as? BindableCollectionViewCell<T> {
            bindable.dataContext = getItemAt(indexPath)
        }
        return cell
    }

    // MARK: UICollectionViewDelegate implementation

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let section = getSectionAt(indexPath.section)
        let item = getItemAt(indexPath)
        self.collectionFrame.onItemSelected(item: item, sectionType: section.type)
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

    }

    // MARK: UICollectionViewDelegateFlowLayout implementation

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 0.0
    }

}
