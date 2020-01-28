//
//  AnalyticsManagerProtocol.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import StoreKit

public protocol AnalyticsManagerProtocol: AnalyticsProviderProtocol {
        
    func registerProvider(_ action: @escaping () -> AnalyticsProviderProtocol)
    
}
