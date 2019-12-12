//
//  CollectionFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

class CollectionFrame<T>: NSObject {
    
    // MARK: Properties
    
    @Bindable(false) private(set) var isEmpty: Bool
    
    @Bindable([T]()) var itemsSource: [T] {
        didSet {
            self.isEmpty = self.itemsSource.isEmpty
        }
    }
    
    // MARK: Actions
    
    private let handleItemSelection: (T) -> Void
    
    // MARK: Init
    
    required override init() {
        self.handleItemSelection = { _ in }
        super.init()
    }
    
    init(itemSelection: @escaping (T) -> Void) {
        self.handleItemSelection = itemSelection
        super.init()
    }
    
    // MARK: Methods
    
    func onItemSelected(item: T) {
        self.handleItemSelection(item)
    }
}
