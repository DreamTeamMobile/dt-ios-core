//
//  SubscriptionManagerProtocol.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import StoreKit

public protocol SubscriptionManagerProtocol {

    var products: [SKProduct] { get }

    var productsLoaded: Bool { get }

    var hasActiveSubscription: Bool { get }

    func loadProducts(completion: ((_ products: [SKProduct]?, _ error: Error?) -> Void)?)

    func checkSubscription(enableSecondCheck: Bool, completion: ((Bool, Error?) -> Void)?)

    func restorePurchases(completion: ((Bool, Error?) -> Void)?)

    func activateSubscription(_ productId: String, completion: ((Bool, Error?) -> Void)?)
}
