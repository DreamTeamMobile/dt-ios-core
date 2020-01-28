//
//  AnalyticsManager.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import StoreKit

public class AnalyticsManager: NSObject, AnalyticsManagerProtocol {
        
    private var providers = [AnalyticsLazyRef]()
    
    private func getProviders() -> [AnalyticsProviderProtocol] {
        return providers.count > 0 ? providers.map({ $0.value }) : [AnalyticsProviderProtocol]()
    }
    
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
    
    public func logPurchase(product: SKProduct, event: String) {
        for item in getProviders() {
            item.logPurchase(product: product, event: event)
        }
    }
    
    public func logPurchase(product: SKProduct, event: String, parameters: [String: Any]?) {
        for item in getProviders() {
            item.logPurchase(product: product, event: event, parameters: parameters)
        }
    }
    
    public func registerProvider(_ action: @escaping () -> AnalyticsProviderProtocol) {
        providers.append(AnalyticsLazyRef(action: action))
    }
    
}
