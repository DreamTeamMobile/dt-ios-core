//
//  CollectionFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public class CollectionFrame<T>: Frame {
    
    // MARK: Properties
    
    @Bindable(false)
    public private(set) var isEmpty: Bool
    
    @Bindable([T]())
    public var itemsSource: [T] {
        didSet {
            self.isEmpty = self.itemsSource.isEmpty
        }
    }
    
    public var actions: [CollectionActionFrame<T>]?
    
    // MARK: Actions
    
    private let handleItemSelection: (T) -> Void
    
    // MARK: Init
    
    required override public init() {
        self.handleItemSelection = { _ in }
        super.init()
    }
    
    public init(itemSelection: @escaping (T) -> Void) {
        self.handleItemSelection = itemSelection
        super.init()
    }
    
    // MARK: Methods
    
    public func onItemSelected(item: T) {
        self.handleItemSelection(item)
    }
}

public struct CollectionActionFrame<T> {
        
    public let type: ActionType
    
    public let title: String
    
    public let action: (T) -> Void
    
    public enum ActionType {
        case normal
        case destructive
    }
}
