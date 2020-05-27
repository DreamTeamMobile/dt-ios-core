//
//  AnalyticsManager.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import StoreKit

public class AnalyticsManager: NSObject, AnalyticsManagerProtocol {
        
    private var providers = [AnalyticsLazyRef]()
    
    public func logEvent(_ event: String) {
        for item in getProviders() {
            item.logEvent(event)
        }
    }
    
    public func logEvent(event: String, parameters: [String: Any]?) {
        for item in getProviders() {
            item.logEvent(event: event, parameters: parameters)
        }
    }
    
    public func logPurchaseEvent(product: SKProduct, event: String) {
        for item in getProviders() {
            item.logPurchaseEvent(product: product, event: event)
        }
    }
    
    public func logPurchaseEvent(product: SKProduct, event: String, parameters: [String: Any]?) {
        for item in getProviders() {
            item.logPurchaseEvent(product: product, event: event, parameters: parameters)
        }
    }
    
    public func logSubscription(product: SKProduct) {
        for item in getProviders() {
            item.logSubscription(product: product)
        }
    }
    
    public func logSubscription(product: SKProduct, parameters: [String: Any]?) {
        for item in getProviders() {
            item.logSubscription(product: product, parameters: parameters)
        }
    }
    
    public func registerProvider(_ action: @escaping () -> AnalyticsProviderProtocol) {
        providers.append(AnalyticsLazyRef(action: action))
    }
    
    public func getProviders() -> [AnalyticsProviderProtocol] {
        return providers.count > 0 ? providers.map({ $0.value }) : [AnalyticsProviderProtocol]()
    }
    
}
