//
//  Dictionary+Extensions.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public extension Dictionary where Key == String, Value == String {
    
    func getLocalizedString() -> String {
        let currentLangKey = Locale.currentLanguageCode
        if let localized = self[currentLangKey]  {
            return localized
        }
        return self["en"] ?? ""
    }
    
}
