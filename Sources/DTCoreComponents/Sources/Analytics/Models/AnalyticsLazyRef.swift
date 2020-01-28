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

    init(action: @escaping () -> AnalyticsProviderProtocol) {
        self.action = action
    }
}
