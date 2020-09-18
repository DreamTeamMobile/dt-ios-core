//
//  AppCenterAnalyticsProvider.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import AppCenterAnalytics
import StoreKit

public class AppCenterAnalyticsProvider: NSObject, AnalyticsProviderProtocol {
    
    public func logEvent(_ event: String) {
        self.logEvent(event: event, parameters: nil)
    }

    public func logEvent(event: String, parameters: [String: Any]?) {
        MSAnalytics.trackEvent(event, withProperties: parameters as? [String: String])
    }

    public func logPurchaseEvent(product: SKProduct, event: String) {
        self.logPurchaseEvent(product: product, event: event, parameters: nil)
    }

    public func logPurchaseEvent(product: SKProduct, event: String, parameters: [String: Any]?) {
        var params = parameters ?? [String: Any]()

        params["productId"] = product.productIdentifier
        params["price"] = product.price.stringValue
        params["currency"] = product.priceLocale.currencyCode ?? ""

        MSAnalytics.trackEvent(event, withProperties: params as? [String: String])
    }
    
    public func logSubscription(product: SKProduct) {
        self.logSubscription(product: product, parameters: nil)
    }

    public func logSubscription(product: SKProduct, parameters: [String: Any]?) {
        // nothing here because AppCenter tracks subscription automatically
    }
    
    public func logPurchase(product: SKProduct) {
        self.logPurchase(product: product, parameters: nil)
    }
    
    public func logPurchase(product: SKProduct, parameters: [String : Any]?) {
        // nothing here because AppCenter tracks purchases automatically
    }

}
