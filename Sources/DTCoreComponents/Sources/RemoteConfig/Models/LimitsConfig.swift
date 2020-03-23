//
//  LimitsConfig.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

open class LimitsConfig : Codable {
    public let items: [LimitItem]
}

open class LimitItem : Codable {
    public let action: String
    public let limit: Int?
}

