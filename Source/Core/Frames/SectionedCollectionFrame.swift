//
//  SectionedCollectionFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public class SectionedCollectionFrame<T>: Frame {
    
    // MARK: Properties
    
    @Bindable(false)
    public private(set) var isEmpty: Bool
    
    @Bindable([Section<T>]())
    public var itemsSource: [Section<T>] {
        didSet {
            self.isEmpty = self.itemsSource.isEmpty
        }
    }
    
    // MARK: Actions
    
    private let handleItemSelection: (T, String) -> Void
    
    // MARK: Init
    
    required override public init() {
        self.handleItemSelection = { _, _ in }
        super.init()
    }
    
    public init(itemSelection: @escaping (T, String) -> Void) {
        self.handleItemSelection = itemSelection
        super.init()
    }
    
    // MARK: Methods
    
    public func onItemSelected(item: T, sectionType: String) {
        self.handleItemSelection(item, sectionType)
    }
    
    public func setItemsSource(_ itemsSource: [(String, [T])]) {
        self.itemsSource = itemsSource.map({ Section<T>(type: $0.0, items: $0.1) })
    }
}

public class Section<T> {
    
    public var type: String
    
    public var items: [T]
    
    public init(type: String, items: [T]) {
        self.type = type
        self.items = items
    }
    
}
