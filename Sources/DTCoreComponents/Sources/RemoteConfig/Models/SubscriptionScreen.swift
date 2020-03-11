//
//  SubscriptionScreen.swift
//  fitnesslab
//
//  Created by Максим Евтух on 11.03.2020.
//  Copyright © 2020 DreamTeamMobile. All rights reserved.
//

import Foundation

open class SubscriptionScreen : Codable {
    
    let id: String
    let type: String
    let title: Control
    let subtitle: Control?
    let desc: Control?
    let achievements: AchievementsConfig
    let button: Control
    let closeButton: Control
    let products: [ProductConfig]
    
}
