//
//  SubscriptionScreen.swift
//  fitnesslab
//
//  Created by Максим Евтух on 11.03.2020.
//  Copyright © 2020 DreamTeamMobile. All rights reserved.
//

import Foundation

open class SubscriptionScreen : Codable {
    
    public let id: String
    public let type: String
    public let title: Control
    public let subtitle: Control?
    public let desc: Control?
    public let achievements: AchievementsConfig
    public let button: Control
    public let closeButton: Control
    public let products: [ProductConfig]
    
}
