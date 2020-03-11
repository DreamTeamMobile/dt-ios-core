//
//  ConfigModel.swift
//  fitnesslab
//
//  Created by Максим Евтух on 28.11.2019.
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

open class ConfigModel {    
    
    public let subscrIntro: SubscriptionConfig
    
    public let subscrLaunch: SubscriptionConfig
    
    public let subscrLimit: SubscriptionConfig
    
    public let products: [Product]
    
    public let subscrScreens: [SubscriptionScreen]
    
    public let limitsConfig: LimitsConfig
    
    public init(subscrIntro: SubscriptionConfig, subscrLaunch: SubscriptionConfig, subscrLimit: SubscriptionConfig, products: [Product], subscrScreens: [SubscriptionScreen], limitsConfig: LimitsConfig) {
        self.subscrIntro = subscrIntro
        self.subscrLaunch = subscrLaunch
        self.subscrLimit = subscrLimit
        self.products = products
        self.subscrScreens = subscrScreens
        self.limitsConfig = limitsConfig
    }
    
}
