//
//  WelcomeConfig.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

open class WelcomeConfig : Codable {
    public let isEnabled: Bool
    public let items: [String]
    
    public init(isEnabled: Bool, items: [String]) {
        self.isEnabled = isEnabled
        self.items = items
    }
}
