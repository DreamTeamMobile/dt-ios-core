//
//  AnalyticsLazyRef.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public struct AnalyticsSettings {
    
    public var providersSettings: [AnalyticsType: AnalyticsProviderSettings]? = nil
    
    public init () {
        
    }
    
    public init(providersSettings: [AnalyticsType : AnalyticsProviderSettings]? = nil) {
        self.providersSettings = providersSettings
    }
    
}
