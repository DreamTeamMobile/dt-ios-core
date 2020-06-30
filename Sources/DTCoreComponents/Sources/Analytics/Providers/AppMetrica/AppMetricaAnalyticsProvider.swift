//
//  AppMetricaAnalyticsProvider.swift
//  DTCore
//
//  Created by Максим Евтух on 30.06.2020.
//  Copyright © 2020 DreamTeam. All rights reserved.
//

import Foundation
import StoreKit
import YandexMobileMetrica

public class AppMetricaAnalyticsProvider: AnalyticsProviderProtocol {
    
    public var apiKey: String = "" {
        didSet {
            if oldValue != self.apiKey {
                initialize()
            }
        }
    }
    
    private func initialize() {
        if let configuration = YMMYandexMetricaConfiguration.init(apiKey: self.apiKey) {
            YMMYandexMetrica.activate(with: configuration)
        }
    }
    
    public func logEvent(_ event: String) {
        self.logEvent(event: event, parameters: nil)
    }

    public func logEvent(event: String, parameters: [String: Any]?) {
        let params: [String: String] = parameters as? [String : String] ?? [:]
        YMMYandexMetrica.reportEvent(event, parameters: params, onFailure: { (error) in
            print("DID FAIL REPORT EVENT: %@", event)
            print("REPORT ERROR: %@", error.localizedDescription)
        })
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
        guard let reporter = YMMYandexMetrica.reporter(forApiKey: self.apiKey) else { return }
        
        let revenueInfo = YMMMutableRevenueInfo.init(priceDecimal: product.price, currency: product.priceLocale.currencyCode ?? "")
        revenueInfo.productID = product.productIdentifier
        revenueInfo.quantity = 1
        revenueInfo.payload = ["type": "subscription", "source": "application"]
        
        reporter.reportRevenue(revenueInfo, onFailure: { (error) in
            print("REPORT ERROR: \(error.localizedDescription)")
        })
    }
    
    public func logPurchase(product: SKProduct) {
        self.logPurchase(product: product, parameters: nil)
    }
    
    public func logPurchase(product: SKProduct, parameters: [String : Any]?) {
        guard let reporter = YMMYandexMetrica.reporter(forApiKey: self.apiKey) else { return }
        
        let revenueInfo = YMMMutableRevenueInfo.init(priceDecimal: product.price, currency: product.priceLocale.currencyCode ?? "")
        revenueInfo.productID = product.productIdentifier
        revenueInfo.quantity = 1
        revenueInfo.payload = ["type": "purchase", "source": "application"]
        
        reporter.reportRevenue(revenueInfo, onFailure: { (error) in
            print("REPORT ERROR: \(error.localizedDescription)")
        })
    }
    
}
