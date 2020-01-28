//
//  AnalyticsManager.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import StoreKit

class AnalyticsManager: NSObject, AnalyticsManagerProtocol {
        
    private var providers = [AnalyticsLazyRef]()
    
    private func getProviders() -> [AnalyticsProviderProtocol] {
        return providers.count > 0 ? providers.map({ $0.value }) : [AnalyticsProviderProtocol]()
    }
    
    func logEvent(_ event: String) {
        for item in getProviders() {
            item.logEvent(event)
        }
    }
    
    func logEvent(event: String, parameters: [String: Any]?) {
        for item in getProviders() {
            item.logEvent(eventType: eventType, parameters: parameters)
        }
    }
    
    func logPurchase(product: SKProduct, event: String) {
        for item in getProviders() {
            item.logPurchase(product: product, event: event)
        }
    }
    
    func logPurchase(product: SKProduct, event: String, parameters: [String: Any]?) {
        for item in getProviders() {
            item.logPurchase(product: product, event: event, parameters: parameters)
        }
    }
    
    func registerProvider(_ action: @escaping () -> AnalyticsProviderProtocol) {
        providers.append(AnalyticsLazyRef(action: action))
    }
    
}
