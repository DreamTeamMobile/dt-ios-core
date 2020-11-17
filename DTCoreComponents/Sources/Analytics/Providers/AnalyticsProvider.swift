//
//  AnalyticsProvider.swift
//  DTCoreComponents
//
//  Copyright © 2020 DreamTeam. All rights reserved.
//

import Foundation

public class AnalyticsProvider: NSObject {
    
    // MARK: Fields
    
    public let settings: AnalyticsProviderSettings
    
    // MARK: Init
    
    public init(settings: AnalyticsProviderSettings?) {
        self.settings = settings ?? AnalyticsProviderSettings()
    }
    
    // MARK: Methods
    
    func canLogEvent() -> Bool {
        return settings.isEventsTrackingEnabled
    }
    
    func canLogPurchases() -> Bool {
        return settings.isIapTrackingEnabled;
    }
    
    func shouldLogPrice() -> Bool {
        return settings.shouldIncludePriceInfoInPurchaseEvent
    }
    
}
