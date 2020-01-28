//
//  FirebaseAnalyticsProvider.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import FirebaseAnalytics
import StoreKit

class FirebaseAnalyticsProvider: NSObject, AnalyticsProviderProtocol {
        
    func logEvent(_ event: String) {
        self.logEvent(eventType: event, parameters: nil)
    }
    
    func logEvent(event: String, parameters: [String: Any]?) {
        Analytics.logEvent(eventType.replacingOccurrences(of: ".", with: "_"), parameters: parameters)
    }
    
    func logPurchase(product: SKProduct, event: String) {
        self.logPurchase(product: product, event: event, parameters: nil)
    }
        
    func logPurchase(product: SKProduct, event: String, parameters: [String: Any]?) {
        var params = parameters ?? [String: Any]()
        
        params["productId"] = product.productIdentifier
        params["price"] = product.price.stringValue
        params["currency"] = product.priceLocale.currencyCode ?? ""
        
        Analytics.logEvent(event, parameters: params)
    }
 
}
