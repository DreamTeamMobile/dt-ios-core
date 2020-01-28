//
//  AppsFlyerAnalyticsProvider.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import StoreKit
import AppsFlyerLib

public class AppsFlyerAnalyticsProvider: AnalyticsProviderProtocol {

    public func logEvent(_ event: String) {
        self.logEvent(event: event, parameters: nil)
    }

    public func logEvent(event: String, parameters: [String : Any]?) {
        let params: [String: String] = parameters as? [String : String] ?? [:]
        AppsFlyerTracker.shared().trackEvent(event, withValues: params)
    }

    public func logPurchase(product: SKProduct, event: String) {
        self.logPurchase(product: product, event: event, parameters: nil)
    }

    public func logPurchase(product: SKProduct, event: String, parameters: [String : Any]?) {
        var params = parameters ?? [String: Any]()
        
        params["productId"] = product.productIdentifier
        params["price"] = product.price.stringValue
        params["currency"] = product.priceLocale.currencyCode ?? ""

        AppsFlyerTracker.shared().trackEvent(event, withValues: params)
        
        AppsFlyerTracker.shared().trackEvent(AFEventSubscribe, withValues: [
            AFEventParamContentId: product.productIdentifier,
            AFEventParamRevenue: product.price.stringValue,
            AFEventParamCurrency: product.priceLocale.currencyCode ?? ""
        ])
    }
    
}
