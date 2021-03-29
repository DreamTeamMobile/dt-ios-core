//
//  StoreReviewManager.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import StoreKit

public class StoreReviewManager: NSObject, StoreReviewProtocol {
    
    public var daysBetweenReviews: Int = 1
    
    private var lastRequestReviewDate: Date? {
        get {
            return UserDefaults.standard.object(forKey: "StoreReviewManager_lastRequestReviewDate") as? Date
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "StoreReviewManager_lastRequestReviewDate")
        }
    }
    
    public func resetLimits() {
        self.lastRequestReviewDate = nil
    }
    
    public func writeReview(appID: String, completion: ((Bool) -> Void)? = nil) -> Bool {
        guard let url = URL(string: "https://apps.apple.com/app/id\(appID)?action=write-review") else { return false }
        guard UIApplication.shared.canOpenURL(url) else { return false }
        
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
        
        return true
    }
    
    public func requestReview() {
        DispatchQueue.main.async {
            SKStoreReviewController.requestReview()
        }
    }
    
    public func requestReviewIfNeeded() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let lastRequestReviewDate = self.lastRequestReviewDate
            let periodDate = Date().subtract(days: self.daysBetweenReviews)
            let isOlderDate = lastRequestReviewDate == nil || periodDate > (lastRequestReviewDate ?? Date())
            
            if (isOlderDate) {
                self.requestReview()
                self.lastRequestReviewDate = Date()
            }
        }
    }
}
