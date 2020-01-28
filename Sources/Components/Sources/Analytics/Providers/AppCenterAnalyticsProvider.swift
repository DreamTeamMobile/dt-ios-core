//
//  AppCenterAnalyticsProvider.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import AppCenterAnalytics
import StoreKit

class AppCenterAnalyricsProvider: AnalyticsProviderProtocol {

    func logEvent(_ event: String) {
        self.logEvent(eventType: event, parameters: nil)
    }

    func logEvent(event: String, parameters: [String: Any]?) {
        MSAnalytics.trackEvent(event, withProperties: parameters as? [String: String])
    }

    func logPurchase(product: SKProduct, event: String) {
        self.logPurchase(product: product, event: event, parameters: nil)
    }

    func logPurchase(product: SKProduct, event: String, parameters: [String: Any]?) {
        var params = parameters ?? [String: Any]()

        params["productId"] = product.productIdentifier
        params["price"] = product.price.stringValue
        params["currency"] = product.priceLocale.currencyCode ?? ""

        MSAnalytics.trackEvent(event, withProperties: params as? [String: String])
    }

}
