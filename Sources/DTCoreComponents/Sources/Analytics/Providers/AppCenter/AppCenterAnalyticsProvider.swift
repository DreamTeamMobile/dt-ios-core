//
//  AppCenterAnalyticsProvider.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import AppCenterAnalytics
import StoreKit

public class AppCenterAnalyricsProvider: NSObject, AnalyticsProviderProtocol {

    public func logEvent(_ event: String) {
        self.logEvent(event: event, parameters: nil)
    }

    public func logEvent(event: String, parameters: [String: Any]?) {
        MSAnalytics.trackEvent(event, withProperties: parameters as? [String: String])
    }

    public func logPurchase(product: SKProduct, event: String) {
        self.logPurchase(product: product, event: event, parameters: nil)
    }

    public func logPurchase(product: SKProduct, event: String, parameters: [String: Any]?) {
        var params = parameters ?? [String: Any]()

        params["productId"] = product.productIdentifier
        params["price"] = product.price.stringValue
        params["currency"] = product.priceLocale.currencyCode ?? ""

        MSAnalytics.trackEvent(event, withProperties: params as? [String: String])
    }

}
