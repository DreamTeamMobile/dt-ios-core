//
//  AppsFlyerAnalyticsProvider.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import StoreKit
import AppsFlyerLib

public class AppsFlyerAnalyticsProvider: NSObject, AnalyticsProviderProtocol {

    public func logEvent(_ event: String) {
        self.logEvent(event: event, parameters: nil)
    }

    public func logEvent(event: String, parameters: [String : Any]?) {
        let params: [String: String] = parameters as? [String : String] ?? [:]
        AppsFlyerLib.shared().logEvent(event, withValues: params)
    }

    public func logPurchaseEvent(product: SKProduct, event: String) {
        self.logPurchaseEvent(product: product, event: event, parameters: nil)
    }

    public func logPurchaseEvent(product: SKProduct, event: String, parameters: [String : Any]?) {
        var params = parameters ?? [String: Any]()
        
        params["productId"] = product.productIdentifier
        params["price"] = product.price.stringValue
        params["currency"] = product.priceLocale.currencyCode ?? ""

        AppsFlyerLib.shared().logEvent(event, withValues: params)
    }
    
    public func logSubscription(product: SKProduct) {
        self.logSubscription(product: product, parameters: nil)
    }

    public func logSubscription(product: SKProduct, parameters: [String: Any]?) {
        var params = parameters ?? [String: Any]()
        
        params[AFEventParamContentId] = product.productIdentifier
        params[AFEventParamRevenue] = product.price.stringValue
        params[AFEventParamCurrency] = (product.priceLocale.currencyCode ?? "")!
        
        AppsFlyerLib.shared().logEvent(AFEventSubscribe, withValues: params)
    }
    
    public func logPurchase(product: SKProduct) {
        self.logPurchase(product: product, parameters: nil)
    }
    
    public func logPurchase(product: SKProduct, parameters: [String: Any]?) {
        var params = parameters ?? [String: Any]()
        
        params[AFEventParamContentId] = product.productIdentifier
        params[AFEventParamRevenue] = product.price.stringValue
        params[AFEventParamCurrency] = (product.priceLocale.currencyCode ?? "")!
        
        AppsFlyerLib.shared().logEvent(AFEventPurchase, withValues: params)
    }
    
}
