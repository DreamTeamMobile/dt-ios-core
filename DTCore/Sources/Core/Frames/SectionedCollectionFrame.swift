//
//  SectionedCollectionFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public class SectionedCollectionFrame<ItemType, SectionType>: CollectionFrame<Section<ItemType, SectionType>> {
    
    // MARK: Actions
    
    private let handleItemSelection: (ItemType, SectionType) -> Void
    
    // MARK: Init
    
    required public init() {
        self.handleItemSelection = { _, _ in }
        super.init()
    }
    
    public init(itemSelection: @escaping (ItemType, SectionType) -> Void) {
        self.handleItemSelection = itemSelection
        super.init()
    }
    
    // MARK: Methods
    
    public func onItemSelected(item: ItemType, sectionType: SectionType) {
        self.handleItemSelection(item, sectionType)
    }
    
    public func setItemsSource(_ itemsSource: [(SectionType, [ItemType])]) {
        self.itemsSource = itemsSource.map {
            let section = Section<ItemType, SectionType>(type: $0.0, items: $0.1)
            section.handleItemSelection = self.handleItemSelection
            return section
        }
    }
}
