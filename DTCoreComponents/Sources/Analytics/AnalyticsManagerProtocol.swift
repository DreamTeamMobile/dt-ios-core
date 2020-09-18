//
//  AnalyticsManagerProtocol.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import StoreKit

public protocol AnalyticsManagerProtocol {
    
    func registerProviders(_ providers: Set<AnalyticsType>)
    
    func getProviders() -> [(AnalyticsType, AnalyticsProviderProtocol)]
    
    func logEvent(_ event: String)
    
    func logEvent(event: String, parameters: [String: Any]?, exclude: Set<AnalyticsType>?)
    
    func logPurchaseEvent(product: SKProduct, event: String)
    
    func logPurchaseEvent(product: SKProduct, event: String, parameters: [String: Any]?, exclude: Set<AnalyticsType>?)
    
    func logSubscription(product: SKProduct)
    
    func logSubscription(product: SKProduct, parameters: [String: Any]?, exclude: Set<AnalyticsType>?)
    
    func logPurchase(product: SKProduct)
    
    func logPurchase(product: SKProduct, parameters: [String: Any]?, exclude: Set<AnalyticsType>?)
    
}
