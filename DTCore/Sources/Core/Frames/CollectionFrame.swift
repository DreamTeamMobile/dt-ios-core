//
//  CollectionFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import UIKit

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

public class CollectionActionFrame<T>: Frame {
    
    public let image: UIImage?
    
    public let backgroundColor: UIColor?
    
    public let type: ActionType
    
    public let title: String
    
    public let action: (T) -> Void
    
    public init(type: ActionType, title: String, image: UIImage?, backgroundColor: UIColor?, action: @escaping (T) -> Void) {
        self.type = type
        self.title = title
        self.image = image
        self.backgroundColor = backgroundColor
        self.action = action
    }
    
    public enum ActionType {
        case normal
        case destructive
    }
}
