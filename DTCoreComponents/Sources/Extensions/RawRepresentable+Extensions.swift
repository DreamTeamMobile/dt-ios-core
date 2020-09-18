//
//  RawRepresentable+Extensions.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public extension RawRepresentable {
    
    var localized: String {
        get {
            return NSLocalizedString(self.rawValue as? String ?? "", comment: "")   
        }
    }
    
}
