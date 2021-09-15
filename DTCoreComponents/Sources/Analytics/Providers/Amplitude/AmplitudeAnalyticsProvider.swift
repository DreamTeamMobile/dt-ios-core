//
//  AmplitudeAnalyticsProvider.swift
//  DTCoreComponents
//
//  Created by Максим Евтух on 15.09.2021.
//  Copyright © 2021 DreamTeam. All rights reserved.
//

import Foundation
import Amplitude
import StoreKit

class AmplitudeAnalyticsProvider: AnalyticsProvider, AnalyticsProviderProtocol {
    
    public func logEvent(_ event: String) {
        self.logEvent(event: event, parameters: nil)
    }

    public func logEvent(event: String, parameters: [String: Any]?) {
        Amplitude.instance().logEvent(event, withEventProperties: params as? [String: String])
    }

    public func logPurchaseEvent(product: SKProduct, event: String) {
        self.logPurchaseEvent(product: product, event: event, parameters: nil)
    }

    public func logPurchaseEvent(product: SKProduct, event: String, parameters: [String: Any]?) {
        var params = parameters ?? [String: Any]()

        params["productId"] = product.productIdentifier

        if shouldLogPrice() {
            params["price"] = product.price.stringValue
            params["currency"] = product.priceLocale.currencyCode ?? ""
        }

        Amplitude.instance().logEvent(event, withEventProperties: params as? [String: String])
    }

    public func logSubscription(product: SKProduct) {
        self.logSubscription(product: product, parameters: nil)
    }

    public func logSubscription(product: SKProduct, parameters: [String: Any]?) {
        Amplitude.instance().logRevenueV2(
            AMPRevenue()
                .setProductIdentifier(product.productIdentifier)
                .setPrice(product.price)
                .setEventProperties([
                    "currency": product.priceLocale.currencyCode ?? ""
                ])
        )
    }

    public func logPurchase(product: SKProduct) {
        self.logPurchase(product: product, parameters: nil)
    }

    public func logPurchase(product: SKProduct, parameters: [String: Any]?) {
        self.logSubscription(product: product, parameters: parameters)
    }
    
}
