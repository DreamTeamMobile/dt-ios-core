//
//  AnalyticsProvider.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import StoreKit

public protocol AnalyticsProviderProtocol: class {
    
    func logEvent(_ event: String)
    
    func logEvent(event: String, parameters: [String: Any]?)
    
    func logPurchaseEvent(product: SKProduct, event: String)
    
    func logPurchaseEvent(product: SKProduct, event: String, parameters: [String: Any]?)
    
    func logSubscription(product: SKProduct)
    
    func logSubscription(product: SKProduct, parameters: [String: Any]?)
    
}
