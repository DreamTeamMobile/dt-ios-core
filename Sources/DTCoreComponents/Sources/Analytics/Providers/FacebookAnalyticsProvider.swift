//
//  FacebookAnalyticsProvider.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import StoreKit

class FacebookAnalyticsProvider: AnalyticsProviderProtocol {

    static let shared = FacebookAnalyticsProvider()

    func logEvent(_ event: String) {
        self.logEvent(eventType: event, parameters: nil)
    }

    func logEvent(event: String, parameters: [String : Any]?) {
        AppEvents.logEvent(AppEvents.Name(rawValue: eventType), parameters: parameters ?? [:])
    }

    func logPurchase(product: SKProduct, event: String) {
        self.logPurchase(product: product, event: event, parameters: nil)
    }

    func logPurchase(product: SKProduct, event: String, parameters: [String : Any]?) {
        var params = parameters ?? [String: Any]()

        params["productId"] = product.productIdentifier
        params["price"] = product.price.stringValue
        params["currency"] = product.priceLocale.currencyCode ?? ""

        AppEvents.logEvent(AppEvents.Name(rawValue: event), parameters: params)
        
        AppEvents.logPurchase(Double(truncating: product.price), currency: product.priceLocale.currencyCode ?? "", parameters: ["productId" : product.productIdentifier])
    }
    
}
