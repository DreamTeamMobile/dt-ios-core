//
//  AchievementsConfig.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

open class AchievementsConfig : Codable {
    
    public let items: [ [String: String] ]?
    
    public let theme: Control.Theme?
    
    public init(items: [[String : String]]?, theme: Control.Theme?) {
        self.items = items
        self.theme = theme
    }
    
}
