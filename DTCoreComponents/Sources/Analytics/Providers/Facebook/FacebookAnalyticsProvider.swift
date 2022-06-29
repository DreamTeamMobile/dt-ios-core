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
        let newParams: [AppEvents.ParameterName: Any]? = Dictionary(uniqueKeysWithValues: parameters?.map{ key, value in
            (AppEvents.ParameterName(key), value)
        } ?? [])
        AppEvents.shared.logEvent(AppEvents.Name(rawValue: event), parameters: newParams ?? [:])
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
        
        let newParams: [AppEvents.ParameterName: Any]? = Dictionary(uniqueKeysWithValues: parameters?.map{ key, value in
            (AppEvents.ParameterName(key), value)
        } ?? [])
        AppEvents.shared.logEvent(AppEvents.Name(rawValue: event), parameters: newParams ?? [:])
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
        
        let newParams: [AppEvents.ParameterName: Any]? = Dictionary(uniqueKeysWithValues: parameters?.map{ key, value in
            (AppEvents.ParameterName(key), value)
        } ?? [])
        AppEvents.shared.logEvent(AppEvents.Name(rawValue: "Subscribe"), parameters: newParams ?? [:])
    }

    public func logPurchase(product: SKProduct) {
        self.logPurchase(product: product, parameters: nil)
    }

    public func logPurchase(product: SKProduct, parameters: [String: Any]?) {
        var params = parameters ?? [String: Any]()
        params["productId"] = product.productIdentifier
        
        let newParams: [AppEvents.ParameterName: Any]? = Dictionary(uniqueKeysWithValues: params.map{ key, value in
            (AppEvents.ParameterName(key), value)
        } ?? [])
        AppEvents.shared.logPurchase(
            amount: shouldLogPrice() ? Double(truncating: product.price) : 0,
            currency: shouldLogPrice() ? (product.priceLocale.currencyCode ?? "") : "",
            parameters: newParams ?? [:])
    }

}
