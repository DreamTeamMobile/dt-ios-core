//
//  FacebookAnalyticsProvider.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import FBSDKCoreKit
import Foundation
import StoreKit

public class FacebookAnalyticsProvider: AnalyticsProvider, AnalyticsProviderProtocol {

    public func logEvent(_ event: String) {
        self.logEvent(event: event, parameters: nil)
    }

    public func logEvent(event: String, parameters: [String: Any]?) {
        AppEvents.logEvent(AppEvents.Name(rawValue: event), parameters: parameters ?? [:])
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

        AppEvents.logEvent(AppEvents.Name(rawValue: event), parameters: params)
    }

    public func logSubscription(product: SKProduct) {
        self.logSubscription(product: product, parameters: nil)
    }

    public func logSubscription(product: SKProduct, parameters: [String: Any]?) {
        var params = parameters ?? [String: Any]()

        params["productId"] = product.productIdentifier

        if shouldLogPrice() {
            params["price"] = product.price.stringValue
            params["currency"] = product.priceLocale.currencyCode ?? ""
        }

        AppEvents.logEvent(AppEvents.Name(rawValue: "Subscribe"), parameters: params)
    }

    public func logPurchase(product: SKProduct) {
        self.logPurchase(product: product, parameters: nil)
    }

    public func logPurchase(product: SKProduct, parameters: [String: Any]?) {
        var params = parameters ?? [String: Any]()
        params["productId"] = product.productIdentifier
        AppEvents.logPurchase(
            shouldLogPrice() ? Double(truncating: product.price) : 0,
            currency: shouldLogPrice() ? (product.priceLocale.currencyCode ?? "") : "",
            parameters: params
        )
    }

}
