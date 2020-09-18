//
//  LimitsConfig.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

open class LimitsConfig : Codable {
    public let items: [LimitItem]
    
    public init(items: [LimitItem]) {
        self.items = items
    }
}

open class LimitItem : Codable {
    public let action: String
    public let limit: Int?
    
    public init(action: String, limit: Int?) {
        self.action = action
        self.limit = limit
    }
}

