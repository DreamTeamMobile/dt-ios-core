//
//  SubscriptionScreen.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

open class SubscriptionScreen : Codable {
    public let id: String
    public let type: String
    public let title: Control?
    public let subtitle: Control?
    public let desc: Control?
    public let achievements: AchievementsConfig?
    public let button: Control
    public let closeButton: Control
    public let products: [RCProductConfig]
    public let purchases: PurchasesControl?
    
    public init(id: String, type: String, title: Control?, subtitle: Control?, desc: Control?, achievements: AchievementsConfig?, button: Control, closeButton: Control, products: [RCProductConfig], purchases: PurchasesControl?) {
        self.id = id
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.desc = desc
        self.achievements = achievements
        self.button = button
        self.closeButton = closeButton
        self.products = products
        self.purchases = purchases
    }
}
