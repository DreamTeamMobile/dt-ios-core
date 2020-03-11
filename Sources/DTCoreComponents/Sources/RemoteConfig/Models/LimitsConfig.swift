//
//  LimitsConfig.swift
//  fitnesslab
//
//  Created by Максим Евтух on 11.03.2020.
//  Copyright © 2020 DreamTeamMobile. All rights reserved.
//

import Foundation

open class LimitsConfig : Codable {
    let items: [LimitItem]
}

open class LimitItem : Codable {
    let action: String
    let limit: Int?
}

