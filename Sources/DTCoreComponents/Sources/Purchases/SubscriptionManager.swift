//
//  SubscriptionManager.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import StoreKit

public class SubscriptionManager: NSObject, SubscriptionManagerProtocol {
        
    static let productsLoadedNotificationName = Notification.Name("SubscriptionManager_productsLoadedNotificationName")
    
    private let productIds: [String]
    
    public private(set) var productsLoaded = false
    
    public private(set) var wasCheckedOnce = false
    
    public private(set) var products = [SKProduct]()
    
    @UserDefault("hasActiveSubscription", defaultValue: false)
    public private(set) var hasActiveSubscription: Bool
    
    // MARK: Dependencies
    
    private let purchaseManager: PurchaseManagerProtocol
    
    // MARK: Init
    
    public init(purchaseManager: PurchaseManagerProtocol, productIds: [String]) {
        self.purchaseManager = purchaseManager
        self.productIds = productIds
    }
    
    // MARK: Methods
    
    public func loadProducts(completion: ((_ products: [SKProduct]?, _ error: Error?) -> Void)? = nil) {
        self.purchaseManager.addProducts(Set(self.productIds))
        self.purchaseManager.requestProducts {[weak self] skProducts, error in
            guard let strongSelf = self else { return }
            
            if let products = skProducts {
                strongSelf.productsLoaded = true
                strongSelf.products = products
                strongSelf.checkSubscription(enableSecondCheck: true)
                
                NotificationCenter.default.post(name: SubscriptionManager.productsLoadedNotificationName, object: nil)
            }
            
            completion?(skProducts, error)
        }
    }
    
    public func checkSubscription(enableSecondCheck: Bool = false, completion: ((Bool, Error?) -> Void)? = nil) {
        if self.productsLoaded {
            self.purchaseManager.checkSubscription(withAppleCheck: true) { [weak self] (isValid, error) in
                guard let strongSelf = self else {
                    return
                }
                
                if let nsErr = error as NSError?, nsErr.code == -1009 {
                    if strongSelf.hasActiveSubscription {
                        return
                    } else {
                        strongSelf.wasCheckedOnce = true
                    }
                }
                
                if isValid {
                    strongSelf.wasCheckedOnce = false
                    strongSelf.hasActiveSubscription = isValid
                    completion?(isValid, error)
                } else if enableSecondCheck && !strongSelf.wasCheckedOnce {
                    strongSelf.wasCheckedOnce = true
                    strongSelf.restorePurchases {[weak self] (success, error) in
                        self?.checkSubscription(enableSecondCheck: false, completion: completion)
                    }
                } else {
                    strongSelf.wasCheckedOnce = false
                    strongSelf.hasActiveSubscription = isValid
                    completion?(isValid, error)
                }
            }
        } else {
            completion?(false, nil)
        }
    }
    
    public func restorePurchases(completion: ((Bool, Error?) -> Void)? = nil) {
        self.purchaseManager.restoreCompletedTransactions { (error) in
            completion?(error == nil, error)
        }
    }
    
    public func activateSubscription(_ productId: String, completion: ((Bool, Error?) -> Void)? = nil) {
        guard self.productsLoaded else { return }
        
        if self.purchaseManager.canMakePurchase(), let product = (self.products.filter{$0.productIdentifier == productId}).first {
            self.purchaseManager.purchase(product) { (productId, error) in
                completion?(productId != nil && error == nil, error)
            }
        } else {
            completion?(false, nil)
        }
    }

}
