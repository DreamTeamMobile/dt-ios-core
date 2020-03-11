//
//  LimitsConfig.swift
//  fitnesslab
//
//  Created by Максим Евтух on 11.03.2020.
//  Copyright © 2020 DreamTeamMobile. All rights reserved.
//

import Foundation

open class LimitsConfig : Codable {
    public let items: [LimitItem]
}

open class LimitItem : Codable {
    public let action: String
    public let limit: Int?
}

