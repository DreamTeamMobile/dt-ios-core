//
//  Section.swift
//  DTCore
//
//  Created by Максим Евтух on 25.06.2020.
//  Copyright © 2020 DreamTeam. All rights reserved.
//

import Foundation

public class Section<ItemType, SectionType> {
    
    public var type: SectionType
    
    @Bindable([ItemType]())
    public var itemsSource: [ItemType]
    
    public var handleItemSelection: ((ItemType, SectionType) -> Void)? = nil
    
    public init(type: SectionType, items: [ItemType]) {
        self.type = type
        self.itemsSource = items
    }
    
}
