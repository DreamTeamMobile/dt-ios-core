//
//  SubscriptionConfig.swift
//  fitnesslab
//
//  Created by Максим Евтух on 11.03.2020.
//  Copyright © 2020 DreamTeamMobile. All rights reserved.
//

import Foundation

open class SubscriptionConfig : Codable {
    let isEnabled: Bool
    let id: String
    let which: Int?
    let specialId: String?
}
