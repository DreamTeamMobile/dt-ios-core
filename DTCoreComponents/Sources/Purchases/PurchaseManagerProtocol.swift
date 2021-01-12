//
//  PurchaseManagerProtocol.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import StoreKit

public protocol PurchaseManagerProtocol {

    var defaultPurchaseCompletion: ((String?, Error?) -> Void)? { get set }
    
    func addProducts(_ ids: Set<String>)

    func addNonConsumables(_ ids: Set<String>)

    func requestProducts(
        _ completionHandler: @escaping (_ products: [SKProduct]?, _ error: Error?) -> Void
    )

    func checkSubscription(withAppleCheck: Bool, completion: ((Bool, Error?) -> Void)?)

    func restoreCompletedTransactions(completion: @escaping (Error?) -> Void)

    func canMakePurchase() -> Bool

    func purchase(_ product: SKProduct, _ completion: ((String?, Error?) -> Void)?)

    func registerObserver()

    func removeObserver()
}
