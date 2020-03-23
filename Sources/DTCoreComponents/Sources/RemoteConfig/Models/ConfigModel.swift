//
//  ConfigModel.swift
//
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
    
    public let welcomeConfig: WelcomeConfig?
    
    public let welcomeScreens: [SubscriptionScreen]?
    
    public init(subscrIntro: SubscriptionConfig, subscrLaunch: SubscriptionConfig, subscrLimit: SubscriptionConfig, products: [Product], subscrScreens: [SubscriptionScreen], limitsConfig: LimitsConfig, welcomeConfig: WelcomeConfig?, welcomeScreens: [SubscriptionScreen]?) {
        self.subscrIntro = subscrIntro
        self.subscrLaunch = subscrLaunch
        self.subscrLimit = subscrLimit
        self.products = products
        self.subscrScreens = subscrScreens
        self.limitsConfig = limitsConfig
        self.welcomeConfig = welcomeConfig
        self.welcomeScreens = welcomeScreens
    }
    
}
