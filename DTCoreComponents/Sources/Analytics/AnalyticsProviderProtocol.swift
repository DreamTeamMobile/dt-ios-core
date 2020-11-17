//
//  AnalyticsProvider.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import StoreKit

public protocol AnalyticsProviderProtocol: class {
    
    var settings: AnalyticsProviderSettings { get }
    
    func logEvent(_ event: String)
    
    func logEvent(event: String, parameters: [String: Any]?)
    
    func logPurchaseEvent(product: SKProduct, event: String)
    
    func logPurchaseEvent(product: SKProduct, event: String, parameters: [String: Any]?)
    
    func logSubscription(product: SKProduct)
    
    func logSubscription(product: SKProduct, parameters: [String: Any]?)
    
    func logPurchase(product: SKProduct)
    
    func logPurchase(product: SKProduct, parameters: [String: Any]?)
    
}
