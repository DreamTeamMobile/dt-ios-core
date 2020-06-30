//
//  SingularAnalyticsProvider.swift
//  DTCore
//
//  Created by Максим Евтух on 30.06.2020.
//  Copyright © 2020 DreamTeam. All rights reserved.
//

import Foundation
import Singular
import StoreKit

public class SingularAnalyticsProvider: AnalyticsProviderProtocol {

    private var apiKey: String = ""

    public func initialize(apiKey: String, secret: String) {
        Singular.startSession(apiKey, withKey: secret)
    }

    public func logEvent(_ event: String) {
        self.logEvent(event: event, parameters: nil)
    }

    public func logEvent(event: String, parameters: [String: Any]?) {
        let params: [String: String] = parameters as? [String: String] ?? [:]
        Singular.event(event, withArgs: params)
    }

    public func logPurchaseEvent(product: SKProduct, event: String) {
        self.logPurchaseEvent(product: product, event: event, parameters: nil)
    }

    public func logPurchaseEvent(product: SKProduct, event: String, parameters: [String: Any]?) {
        var params = parameters ?? [String: Any]()

        params["productId"] = product.productIdentifier
        params["price"] = product.price.stringValue
        params["currency"] = product.priceLocale.currencyCode ?? ""

        self.logEvent(event: event, parameters: params)
    }

    public func logSubscription(product: SKProduct) {
        self.logSubscription(product: product, parameters: nil)
    }

    public func logSubscription(product: SKProduct, parameters: [String: Any]?) {
        var params = parameters ?? [String: Any]()

        params["productId"] = product.productIdentifier
        params["price"] = product.price.stringValue
        params["currency"] = product.priceLocale.currencyCode ?? ""
        params["type"] = "subscription"

        Singular.revenue(
            product.priceLocale.currencyCode ?? "",
            amount: product.price.doubleValue,
            withAttributes: params
        )
    }

    public func logPurchase(product: SKProduct) {
        self.logPurchase(product: product, parameters: nil)
    }

    public func logPurchase(product: SKProduct, parameters: [String: Any]?) {
        var params = parameters ?? [String: Any]()

        params["productId"] = product.productIdentifier
        params["price"] = product.price.stringValue
        params["currency"] = product.priceLocale.currencyCode ?? ""
        params["type"] = "purchase"

        Singular.revenue(
            product.priceLocale.currencyCode ?? "",
            amount: product.price.doubleValue,
            withAttributes: params
        )
    }

}
