//
//  ProductConfig.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

open class RCProductConfig : Codable {
    public let id: String
    public let selected: Bool
    
    public init(id: String, selected: Bool) {
        self.id = id
        self.selected = selected
    }
}
