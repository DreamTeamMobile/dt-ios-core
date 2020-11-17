//
//  AnalyticsProviderSettings.swift
//  DTCoreComponents
//
//  Created by Максим Евтух on 17.11.2020.
//  Copyright © 2020 DreamTeam. All rights reserved.
//

import Foundation

public struct AnalyticsProviderSettings {
    public var isEventsTrackingEnabled: Bool = true
    public var isIapTrackingEnabled: Bool = true
    public var shouldIncludePriceInfoInPurchaseEvent: Bool = true
}
