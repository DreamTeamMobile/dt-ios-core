//
//  AnalyticsProviderSettings.swift
//  DTCoreComponents
//
//  Created by Максим Евтух on 17.11.2020.
//  Copyright © 2020 DreamTeam. All rights reserved.
//

import Foundation

public struct AnalyticsProviderSettings {
    var isEventsTrackingEnabled: Bool = true
    var isIapTrackingEnabled: Bool = true
    var shouldIncludePriceInfoInPurchaseEvent: Bool = true
}
