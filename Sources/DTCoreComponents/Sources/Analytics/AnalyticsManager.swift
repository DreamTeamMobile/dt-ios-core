//
//  AnalyticsManager.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import StoreKit

public class AnalyticsManager: NSObject, AnalyticsManagerProtocol {
    
    // MARK: Fields
    
    private var providers = [AnalyticsLazyRef]()
    
    // MARK: Private methods
    
    private func getLazyRef(for type: AnalyticsType) -> AnalyticsLazyRef {
        switch type {
        case .firebase:
            return AnalyticsLazyRef(type: type, action: { FirebaseAnalyticsProvider() })
        case .facebook:
            return AnalyticsLazyRef(type: type, action: { FacebookAnalyticsProvider() })
        case .appsFlyer:
            return AnalyticsLazyRef(type: type, action: { AppsFlyerAnalyticsProvider() })
        case .appCenter:
            return AnalyticsLazyRef(type: type, action: { AppCenterAnalyticsProvider() })
        }
    }
    
    private func executeIfNotExcluded(_ tuple: (AnalyticsType, AnalyticsProviderProtocol), exclude: Set<AnalyticsType>?, completion: (AnalyticsProviderProtocol) -> Void) {
        let type = tuple.0
        let provider = tuple.1
        guard !(exclude?.contains(type) ?? false) else { return }
        completion(provider)
    }
    
    // MARK: Public methods
    
    // MARK: Analytics methods
    
    public func logEvent(_ event: String) {
        self.logEvent(event: event, parameters: nil, exclude: nil)
    }
    
    public func logEvent(event: String, parameters: [String: Any]?, exclude: Set<AnalyticsType>?) {
        for tuple in getProviders() {
            executeIfNotExcluded(tuple, exclude: exclude) { provider in
                provider.logEvent(event: event, parameters: parameters)
            }
        }
    }
    
    public func logPurchaseEvent(product: SKProduct, event: String) {
        self.logPurchaseEvent(product: product, event: event, parameters: nil, exclude: nil)
    }
    
    public func logPurchaseEvent(product: SKProduct, event: String, parameters: [String: Any]?, exclude: Set<AnalyticsType>?) {
        for tuple in getProviders() {
            executeIfNotExcluded(tuple, exclude: exclude) { provider in
                provider.logPurchaseEvent(product: product, event: event, parameters: parameters)
            }
        }
    }
    
    public func logSubscription(product: SKProduct) {
        self.logSubscription(product: product, parameters: nil, exclude: nil)
    }
    
    public func logSubscription(product: SKProduct, parameters: [String: Any]?, exclude: Set<AnalyticsType>?) {
        for tuple in getProviders() {
            executeIfNotExcluded(tuple, exclude: exclude) { provider in
                provider.logSubscription(product: product, parameters: parameters)
            }
        }
    }
    
    public func logPurchase(product: SKProduct) {
        self.logPurchase(product: product, parameters: nil, exclude: nil)
    }
    
    public func logPurchase(product: SKProduct, parameters: [String : Any]?, exclude: Set<AnalyticsType>?) {
        for tuple in getProviders() {
            executeIfNotExcluded(tuple, exclude: exclude) { provider in
                provider.logPurchase(product: product, parameters: parameters)
            }
        }
    }
    
    // MARK: Providers methods
    
    public func registerProviders(_ providers: Set<AnalyticsType>) {
        for provider in providers {
            self.providers.append(getLazyRef(for: provider))
        }
    }
    
    public func getProviders() -> [(AnalyticsType, AnalyticsProviderProtocol)] {
        return providers.count > 0 ? providers.map { ($0.type, $0.value) } : []
    }
    
}
