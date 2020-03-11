//
//  SubscriptionConfig.swift
//  fitnesslab
//
//  Created by Максим Евтух on 11.03.2020.
//  Copyright © 2020 DreamTeamMobile. All rights reserved.
//

import Foundation

open class SubscriptionConfig : Codable {
    public let isEnabled: Bool
    public let id: String
    public let which: Int?
    public let specialId: String?
}
