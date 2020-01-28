//
//  FacebookAnalyticsProvider.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import StoreKit

public class FacebookAnalyticsProvider: AnalyticsProviderProtocol {

    public func logEvent(_ event: String) {
        self.logEvent(event: event, parameters: nil)
    }

    public func logEvent(event: String, parameters: [String : Any]?) {
        AppEvents.logEvent(AppEvents.Name(rawValue: event), parameters: parameters ?? [:])
    }

    public func logPurchase(product: SKProduct, event: String) {
        self.logPurchase(product: product, event: event, parameters: nil)
    }

    public func logPurchase(product: SKProduct, event: String, parameters: [String : Any]?) {
        var params = parameters ?? [String: Any]()

        params["productId"] = product.productIdentifier
        params["price"] = product.price.stringValue
        params["currency"] = product.priceLocale.currencyCode ?? ""

        AppEvents.logEvent(AppEvents.Name(rawValue: event), parameters: params)
        
        AppEvents.logPurchase(Double(truncating: product.price), currency: product.priceLocale.currencyCode ?? "", parameters: ["productId" : product.productIdentifier])
    }
    
}
