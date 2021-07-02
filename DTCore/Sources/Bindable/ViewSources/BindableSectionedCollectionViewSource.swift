//
//  BindableSectionedCollectionViewSource.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

open class BindableSectionedCollectionViewSource<ItemType, SectionType> : NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: Fields

    public weak var collectionView: UICollectionView?

    public weak var collectionFrame: SectionedCollectionFrame<ItemType, SectionType>?

    public let cellIdentifiers: [String]

    // MARK: Init
        
    convenience public init(collectionView: UICollectionView, collectionFrame: SectionedCollectionFrame<ItemType, SectionType>) {
        self.init(collectionView: collectionView, collectionFrame: collectionFrame, cellIdentifiers: [])
    }
    
    convenience public init(collectionView: UICollectionView, collectionFrame: SectionedCollectionFrame<ItemType, SectionType>, cellIdentifier: String) {
        self.init(collectionView: collectionView, collectionFrame: collectionFrame, cellIdentifiers: [cellIdentifier])
    }
    
    public init(collectionView: UICollectionView, collectionFrame: SectionedCollectionFrame<ItemType, SectionType>, cellIdentifiers: [String]) {
        self.collectionView = collectionView
        self.collectionFrame = collectionFrame
        self.cellIdentifiers = cellIdentifiers
        
        super.init()
        
        registerCells()
        setupCollectionView()
        setupBindings()
    }

    // MARK: Private methods

    private func registerCells() {
        self.collectionView?.register(identifiers: self.cellIdentifiers)
    }
    
    private func setupCollectionView() {
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
    }

    private func setupBindings() {
        self.collectionFrame?.$itemsSource.bindAndFire(onItemsSourceChanged)
    }

    // MARK: Methods

    open func getItemAt(_ indexPath: IndexPath) -> ItemType? {
        return getSectionAt(indexPath.section)?.itemsSource[indexPath.item]
    }

    open func getSectionAt(_ section: Int) -> Section<ItemType, SectionType>? {
        return self.collectionFrame?.itemsSource[section]
    }

    open func onItemsSourceChanged(_ oldItems: [Section<ItemType, SectionType>], _ newItems: [Section<ItemType, SectionType>]) {
        self.collectionView?.reloadData()
    }

    open func getCellIdentifier(_ indexPath: IndexPath) -> String {
        return self.cellIdentifiers.first!
    }

    // MARK: UICollectionViewDataSource implementation

    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.collectionFrame?.itemsSource.count ?? 0
    }

    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getSectionAt(section)?.itemsSource.count ?? 0
    }

    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: getCellIdentifier(indexPath), for: indexPath)
        if let bindable = cell as? BindableCollectionViewCell<ItemType> {
            bindable.dataContext = getItemAt(indexPath)
        }
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return .init()
    }

    // MARK: UICollectionViewDelegate implementation

    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let section = getSectionAt(indexPath.section), let item = getItemAt(indexPath) else { return }
        self.collectionFrame?.onItemSelected(item: item, sectionType: section.type)
    }

    open func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    open func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    open func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }

    open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

    }
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }

    // MARK: UICollectionViewDelegateFlowLayout implementation

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize ?? .zero
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.headerReferenceSize ?? .zero
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize ?? .zero
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
