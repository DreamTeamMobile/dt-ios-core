//
//  SubscriptionConfig.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

open class SubscriptionConfig : Codable {
    public let isEnabled: Bool
    public let id: String
    public let which: Int?
    public let specialId: String?
    
    public init(isEnabled: Bool, id: String, which: Int?, specialId: String?) {
        self.isEnabled = isEnabled
        self.id = id
        self.which = which
        self.specialId = specialId
    }
    
}
