// Based on https://github.com/sandorgyulai/InAppFramework
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit
import StoreKit
import TPInAppReceipt
import os.log

public class PurchaseManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver, PurchaseManagerProtocol {
        
    fileprivate var restoreCompletion: ((Error?) -> Void)? = nil
    fileprivate var purchaseCompletion: ((String?, Error?) -> Void)? = nil
    
    private let purchasesSecret: String
    
    var productIdentifiers: Set<String>?
    var nonConsumableIdentifiers: Set<String>?
    var productsRequest: SKProductsRequest?
    
    var completionHandler: ((_ products: [SKProduct]?, _ error: Error?) -> Void)?
    
    var purchasedProductIdentifiers = Set<String>()
    
    fileprivate var hasValidReceipt = false
    
    public init(secret: String) {
        self.purchasesSecret = secret
        self.productIdentifiers = Set<String>()
        self.nonConsumableIdentifiers = Set<String>()
    }
    
    @objc public func registerObserver() {
        SKPaymentQueue.default().add(self)
    }
    
    @objc public func removeObserver() {
        SKPaymentQueue.default().remove(self)
    }
    
    /**
     Add a single product ID
     
     - Parameter id: Product ID in string format
     */
    @objc func addProduct(_ id: String) {
        productIdentifiers?.insert(id)
    }
    
    @objc func addNonConsumable(_ id: String) {
        nonConsumableIdentifiers?.insert(id)
    }
    
    /**
     Add multiple product IDs
     
     - Parameter ids: Set of product ID strings you wish to add
     */
    @objc public func addProducts(_ ids: Set<String>) {
        productIdentifiers?.formUnion(ids)
    }
    
    @objc public func addNonConsumables(_ ids: Set<String>) {
        nonConsumableIdentifiers?.formUnion(ids)
    }
    
    /**
     Load purchased products
     
     - Parameter checkWithApple: True if you want to validate the purchase receipt with Apple servers
     */
    func loadPurchasedProducts(validate: Bool, completion: ((_ valid: Bool, _ error: Error?) -> Void)?, sandbox: Bool = false) {
        
        if let productIdentifiers = productIdentifiers {
            os_log("3.productIdentifiers.OK", log: OSLog.default, type: .info)
            
            for productIdentifier in productIdentifiers {
                
                let isPurchased = UserDefaults.standard.bool(forKey: productIdentifier)
                
                if isPurchased {
                    purchasedProductIdentifiers.insert(productIdentifier)
                    print("Purchased: \(productIdentifier)")
                } else {
                    print("Not purchased: \(productIdentifier)")
                }
                
            }
            
            if validate {
                os_log("Checking with Apple...", log: OSLog.default, type: .info)
                validateReceipt(sandbox) { [weak self] (valid, error) in
                    print(valid ? "Receipt is Valid" : "BEWARE! Reciept is not Valid!!!")
                    guard valid else {
                        os_log("8.BEWARE! Reciept is not Valid!!!", log: OSLog.default, type: .info)
                        completion?(false, error)
                        return
                    }
                    print("Checking local receipt...")
                    os_log("8.Receipt is Valid. Checking local receipt...", log: OSLog.default, type: .info)
                    self?.validateLocalReceipt { (active, error) in
                        print(active ? "Receipt is Active!" : "BEWARE! Reciept is not Active!!!")
                        self?.hasValidReceipt = active
                        if active {
                            os_log("10.Receipt is Active!", log: OSLog.default, type: .info)
                        } else {
                            os_log("10.BEWARE! Reciept is not Active!!!", log: OSLog.default, type: .info)
                        }
                        completion?(active, error)
                    }
                }
            } else {
                os_log("8.Without validation", log: OSLog.default, type: .info)
                completion?(true, nil)
            }
        } else {
            os_log("3.productIdentifiers.FAILED", log: OSLog.default, type: .info)
            completion?(false, nil)
        }
        
    }

    fileprivate func validateLocalReceipt(completion: @escaping (_ valid: Bool, _ error: Error?) -> Void) {
        do {
            let receipt = try InAppReceipt.localReceipt()
            print("expiration date: \(receipt.expirationDate ?? "")")
            for productId in purchasedProductIdentifiers {
                if let _ = nonConsumableIdentifiers?.first(where: { receipt.containsPurchase(ofProductIdentifier: $0) }) {
                    os_log("9.Local receipt has active non-consumable purchase", log: OSLog.default, type: .info)
                    completion(true, nil)
                    return
                } else if receipt.autoRenewablePurchases.contains(where: { $0.productIdentifier == productId }) && receipt.hasActiveAutoRenewableSubscription(ofProductIdentifier: productId, forDate: Date()) {
                    os_log("9.Local receipt has active purchase", log: OSLog.default, type: .info)
                    completion(true, nil)
                    return
                }
            }
            os_log("9.Local receipt has no active purchase", log: OSLog.default, type: .info)
            completion(false, nil)
        } catch {
            os_log("9.Local receipt parsing error", log: OSLog.default, type: .info)
            print(error)
            completion(false, error)
        }
    }
    
    fileprivate func validateReceipt(_ sandbox: Bool, completion: @escaping (_ valid: Bool, _ error: Error?) -> Void) {
        
        if let url = Bundle.main.appStoreReceiptURL, let r = try? Data(contentsOf: url) {
            os_log("4.receiptURL and data.OK", log: OSLog.default, type: .info)
            
            let receiptData = r.base64EncodedString(options: NSData.Base64EncodingOptions())
            let requestContent = [ "receipt-data" : receiptData, "password": self.purchasesSecret ]
            
            do {
                let requestData = try JSONSerialization.data(withJSONObject: requestContent, options: JSONSerialization.WritingOptions())
                
                let storeURL = URL(string: "https://buy.itunes.apple.com/verifyReceipt")
                let sandBoxStoreURL = URL(string: "https://sandbox.itunes.apple.com/verifyReceipt")
                
                guard let finalURL = sandbox ? sandBoxStoreURL : storeURL else {
                    return
                }
                
                var storeRequest = URLRequest(url: finalURL)
                storeRequest.httpMethod = "POST"
                storeRequest.httpBody = requestData
                
                let task = URLSession.shared.dataTask(with: storeRequest, completionHandler: { [weak self] (data, response, error) -> Void in
                    if (error != nil) {
                        print("Validation Error: \(String(describing: error))")
                        self?.hasValidReceipt = false
                        os_log("5.Recipt Validation Error", log: OSLog.default, type: .info)
                        completion(false, error)
                    } else {
                        self?.checkStatus(with: data, completion: completion)
                    }
                })
                
                task.resume()
                
            } catch {
                print("validateReceipt: Caught error serializing response JSON")
                os_log("5.validateReceipt: Caught error serializing response JSON", log: OSLog.default, type: .info)
                hasValidReceipt = false
                completion(false, error)
            }
            
        } else {
            os_log("4.receiptURL and data. FAILED", log: OSLog.default, type: .info)
            hasValidReceipt = false
            completion(false, nil)
        }
        
    }
    
    fileprivate func checkStatus(with data: Data?, completion: @escaping (_ valid: Bool, _ error: Error?) -> Void) {
        do {
            if let data = data, let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String: AnyObject] {
                os_log("5.checkStatus. Response. OK", log: OSLog.default, type: .info)
                
                if let status = jsonResponse["status"] as? Int {
                    if status == 0 {
                        print("Status: VALID")
                        hasValidReceipt = true
                        os_log("6.Status: VALID", log: OSLog.default, type: .info)
                        
                        // MARK: non-consumable validation
                        
                        if let latestReceipt = jsonResponse["latest_receipt"] as? String, let data = Data(base64Encoded: latestReceipt), let receipt = try? InAppReceipt.receipt(from: data) {
                            if let purchaseId = nonConsumableIdentifiers?.first(where: { receipt.containsPurchase(ofProductIdentifier: $0) }) {
                                print("Found non-consumable purchase \(purchaseId)")
                                os_log("6.Status: VALID. Found non-consumable purchase", log: OSLog.default, type: .info)
                                completion(true, nil)
                                return
                            }
                        }
                        
                        if let receipt = jsonResponse["receipt"] as? [String: AnyObject] {
                            if let inApps = receipt["in_app"] as? NSArray {
                                if let inApp = inApps.first(where: { (element) -> Bool in
                                        if let iap = element as? [String: AnyObject], let product_id = iap["product_id"] as? String {
                                            return self.nonConsumableIdentifiers?.contains(product_id) ?? false
                                        }
                                        return false
                                    }) {
#if DEBUG
                                    if let purchaseId = (inApp as? [String: AnyObject])?["product_id"] {
                                        print("Found non-consumable purchase \(purchaseId)")
                                    }
#endif
                                    os_log("6.Status: VALID. Found non-consumable purchase", log: OSLog.default, type: .info)
                                    completion(true, nil)
                                    return
                                }
                            }
                        }
                        
                        // MARK: autorenewable subscriptions verification
                        
                        if let array = (jsonResponse["pending_renewal_info"] as? [[String: AnyObject]]) {
                            let activeSubscription = array.first(where: { (dict) -> Bool in
                                // checking active subscription
                                // https://developer.apple.com/documentation/appstorereceipts/expiration_intent
                                guard let expirationIntent = dict["expiration_intent"] as? String else {
                                    return true
                                }
                                
                                // checking subscription in billing retry period
                                // https://developer.apple.com/documentation/appstorereceipts/is_in_billing_retry_period
                                let isInBillingRetryPeriod = dict["is_in_billing_retry_period"] as? String
                                if expirationIntent == "2" && isInBillingRetryPeriod == "1" {
                                    return true
                                }
                                
                                return false
                            })
                            activeSubscription != nil
                                ? os_log("7.Active: TRUE", log: OSLog.default, type: .info)
                                : os_log("7.Active: FALSE", log: OSLog.default, type: .info)
                            
                            completion(activeSubscription != nil, nil)
                        } else {
                            os_log("7.Active: TRUE", log: OSLog.default, type: .info)
                            completion(true, nil)
                        }
                    } else if status == 21007 {
                        print("Status: CHECK WITH SANDBOX")
                        os_log("6.Status: CHECK WITH SANDBOX", log: OSLog.default, type: .info)
                        validateReceipt(true, completion: completion)
                    } else {
                        print("Status: INVALID")
                        os_log("6.Status: INVALID", log: OSLog.default, type: .info)
                        hasValidReceipt = false
                        completion(false, nil)
                    }
                } else {
                    os_log("6.Status: UNKNOWN", log: OSLog.default, type: .info)
                    hasValidReceipt = false
                    completion(false, nil)
                }
            } else {
                os_log("5.checkStatus. Response. FAILED", log: OSLog.default, type: .info)
                hasValidReceipt = false
                completion(false, nil)
            }
        } catch {
            print("checkStatus: Caught error")
            os_log("5.checkStatus: Caught error", log: OSLog.default, type: .info)
            hasValidReceipt = false
            completion(false, error)
        }
    }
    
    /**
     Request products from Apple
     */
    public func requestProducts(_ completionHandler: @escaping (_ products: [SKProduct]?, _ error: Error?) -> Void) {
        self.completionHandler = completionHandler
        
        print("Requesting Products")
        
        if let productIdentifiers = productIdentifiers {
            productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
            productsRequest?.delegate = self
            productsRequest?.start()
        } else {
            print("No productIdentifiers")
            completionHandler(nil, nil)
            self.completionHandler = nil
        }
    }
    
    /**
     Initiate purchase for the product
     
     - Parameter product: The product you want to purchase
     */
    public func purchase(_ product: SKProduct, _ completion: @escaping (String?, Error?) -> Void) {
        print("Purchasing product: \(product.productIdentifier)")
        
        purchaseCompletion = completion
        restoreCompletion = nil
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    /**
     Check if the product with identifier is already purchased
     */
    public func checkPurchase(for productIdentifier: String) -> (isPurchased: Bool, hasValidReceipt: Bool) {
        let purchased = purchasedProductIdentifiers.contains(productIdentifier)
        return (purchased, hasValidReceipt)
    }
    
    /**
     Begin to start restoration of already purchased products
     */
    public func restoreCompletedTransactions(completion: @escaping (Error?) -> Void) {
        purchaseCompletion = nil
        restoreCompletion = completion
        
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    //MARK: - Transactions
    
    fileprivate func completeTransaction(_ transaction: SKPaymentTransaction) {
        print("Complete Transaction...")
        
        provideContentForProductIdentifier(transaction.payment.productIdentifier, isRestore: false)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    fileprivate func restoreTransaction(_ transaction: SKPaymentTransaction) {
        print("Restore Transaction...")
        
        provideContentForProductIdentifier(transaction.original?.payment.productIdentifier, isRestore: true)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    fileprivate func failedTransaction(_ transaction: SKPaymentTransaction) {
        print("Failed Transaction...")
        SKPaymentQueue.default().finishTransaction(transaction)
        
        if let pc = purchaseCompletion {
            pc(nil, transaction.error)
        }
        
        purchaseCompletion = nil
    }
    
    fileprivate func provideContentForProductIdentifier(_ productIdentifier: String?, isRestore: Bool) {
        if let prodId = productIdentifier {
            purchasedProductIdentifiers.insert(prodId)
            
            UserDefaults.standard.set(true, forKey: prodId)
            UserDefaults.standard.synchronize()
            
            if !isRestore, let pc = purchaseCompletion {
                pc(productIdentifier, nil)
            }
            
            purchaseCompletion = nil
        }
    }
    
    // MARK: - Delegate Implementations
    
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions
        {
            if let trans = transaction as? SKPaymentTransaction
            {
                switch trans.transactionState {
                case .purchased:
                    completeTransaction(trans)
                    break
                case .failed:
                    failedTransaction(trans)
                    break
                case .restored:
                    restoreTransaction(trans)
                    break
                default:
                    break
                }
            }
        }
    }
    
    public func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        if let rc = restoreCompletion {
            rc(error)
        }
        
        restoreCompletion = nil
    }
    
    public func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        for transaction in queue.transactions {
            switch transaction.transactionState {
            case .restored:
                var productIdentifier = "";
                if let origin = transaction.original {
                    productIdentifier = origin.payment.productIdentifier;
                }
                else {
                    productIdentifier = transaction.payment.productIdentifier;
                }
                
                provideContentForProductIdentifier(productIdentifier, isRestore: true)
                break
            default:
                break
            }
        }
        
        if let rc = restoreCompletion {
            rc(nil)
        }
        
        restoreCompletion = nil
    }
    
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        print("Loaded product list!")
        
        productsRequest = nil
        
        let skProducts = response.products
        
        for skProduct in skProducts  {
            print("Found product: \(skProduct.productIdentifier) - \(skProduct.localizedTitle) - \(skProduct.price) - \(skProduct.priceLocale)")
        }
        
        if let completionHandler = self.completionHandler {
            completionHandler(skProducts, nil)
        }
        
        self.completionHandler = nil
    }
    
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Failed to load list of products!")
        productsRequest = nil
        if let completionHandler = self.completionHandler {
            completionHandler(nil, error)
        }
        self.completionHandler = nil
    }
    
    //MARK: - Helpers
    
    /**
     Check if the user can make purchase
     */
    public func canMakePurchase() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    //MARK: - Class Functions
    
    /**
     Format the price for the given locale
     
     - Parameter price:  The price you want to format
     - Parameter locale: The price locale you want to format with
     
     - Returns: The formatted price
     */
    class func formatPrice(_ price: NSNumber, locale: Locale) -> String {
        var formattedString = ""
        
        let numberFormatter = NumberFormatter()
        numberFormatter.formatterBehavior = NumberFormatter.Behavior.behavior10_4
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        numberFormatter.locale = locale
        formattedString = numberFormatter.string(from: price) ?? ""
        
        return formattedString
    }
    
    public func checkSubscription(withAppleCheck: Bool, completion: ((Bool, Error?) -> Void)?) {
        #if DEBUG
        let sandbox = true
        #else
        let sandbox = false
        #endif
        
        self.loadPurchasedProducts(validate: withAppleCheck, completion: { (isValid, error) in
            DispatchQueue.main.async {
                completion?(isValid, error)
            }
        }, sandbox: sandbox)
    }
}
