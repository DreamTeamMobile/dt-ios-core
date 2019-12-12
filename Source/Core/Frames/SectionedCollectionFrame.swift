//
//  SectionedCollectionFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public class SectionedCollectionFrame<T>: NSObject {
    
    // MARK: Properties
    
    @Bindable([Section<T>]()) var itemsSource: [Section<T>]
    
    // MARK: Actions
    
    private let handleItemSelection: (T, String) -> Void
    
    // MARK: Init
    
    required override init() {
        self.handleItemSelection = { _, _ in }
        super.init()
    }
    
    init(itemSelection: @escaping (T, String) -> Void) {
        self.handleItemSelection = itemSelection
        super.init()
    }
    
    // MARK: Methods
    
    func onItemSelected(item: T, sectionType: String) {
        self.handleItemSelection(item, sectionType)
    }
    
    func setItemsSource(_ itemsSource: [(String, [T])]) {
        self.itemsSource = itemsSource.map({ Section<T>(type: $0.0, items: $0.1) })
    }
}

public class Section<T> {
    
    var type: String
    
    var items: [T]
    
    init(type: String, items: [T]) {
        self.type = type
        self.items = items
    }
    
}
