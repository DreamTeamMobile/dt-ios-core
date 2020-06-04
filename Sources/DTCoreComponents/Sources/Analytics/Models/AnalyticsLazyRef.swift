//
//  AnalyticsLazyRef.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

class AnalyticsLazyRef {

    lazy var value: AnalyticsProviderProtocol = {
        return self.action()
    }()
    
    private let action: () -> AnalyticsProviderProtocol
    
    let type: AnalyticsType

    init(type: AnalyticsType, action: @escaping () -> AnalyticsProviderProtocol) {
        self.type = type
        self.action = action
    }
}
