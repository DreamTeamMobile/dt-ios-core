//
//  ConfigModel.swift
//  fitnesslab
//
//  Created by Максим Евтух on 28.11.2019.
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

open class ConfigModel {    
    
    let subscrIntro: SubscriptionConfig
    
    let subscrLaunch: SubscriptionConfig
    
    let subscrLimit: SubscriptionConfig
    
    let products: [Product]
    
    let subscrScreens: [SubscriptionScreen]
    
    let limitsConfig: LimitsConfig
    
    init(subscrIntro: SubscriptionConfig, subscrLaunch: SubscriptionConfig, subscrLimit: SubscriptionConfig, products: [Product], subscrScreens: [SubscriptionScreen], limitsConfig: LimitsConfig) {
        self.subscrIntro = subscrIntro
        self.subscrLaunch = subscrLaunch
        self.subscrLimit = subscrLimit
        self.products = products
        self.subscrScreens = subscrScreens
        self.limitsConfig = limitsConfig
    }
    
}
