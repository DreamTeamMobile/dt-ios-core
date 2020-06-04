//
//  FirebaseAnalyticsProvider.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import FirebaseAnalytics
import StoreKit

public class FirebaseAnalyticsProvider: NSObject, AnalyticsProviderProtocol {
        
    public func logEvent(_ event: String) {
        self.logEvent(event: event, parameters: nil)
    }
    
    public func logEvent(event: String, parameters: [String: Any]?) {
        Analytics.logEvent(event.replacingOccurrences(of: ".", with: "_"), parameters: parameters)
    }
    
    public func logPurchaseEvent(product: SKProduct, event: String) {
        self.logPurchaseEvent(product: product, event: event, parameters: nil)
    }
        
    public func logPurchaseEvent(product: SKProduct, event: String, parameters: [String: Any]?) {
        var params = parameters ?? [String: Any]()
        
        params["productId"] = product.productIdentifier
        params["price"] = product.price.stringValue
        params["currency"] = product.priceLocale.currencyCode ?? ""
        
        Analytics.logEvent(event, parameters: params)
    }
 
    public func logSubscription(product: SKProduct) {
        self.logSubscription(product: product, parameters: nil)
    }

    public func logSubscription(product: SKProduct, parameters: [String: Any]?) {
        // nothing here because Firebase tracks subscription automatically
    }
    
    public func logPurchase(product: SKProduct) {
        self.logPurchase(product: product, parameters: nil)
    }
    
    public func logPurchase(product: SKProduct, parameters: [String : Any]?) {
        // nothing here because Firebase tracks purchases automatically
    }
}
