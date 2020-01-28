//
//  AnalyticsProvider.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import StoreKit

protocol AnalyticsProviderProtocol: class {
    
    func logEvent(_ event: String)
    
    func logEvent(event: String, parameters: [String: Any]?)
    
    func logPurchase(product: SKProduct, event: String)
    
    func logPurchase(product: SKProduct, event: String, parameters: [String: Any]?)
    
}
