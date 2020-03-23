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
}
