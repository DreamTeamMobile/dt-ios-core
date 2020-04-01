//
//  Locale+Extensions.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public extension Locale {
    
    static var currentLanguage: String {
        get {
            if let language = preferredLanguages.first,
               let code = Locale(identifier: language).languageCode,
               let _ = Bundle.main.path(forResource: language, ofType: "lproj") ?? Bundle.main.path(forResource: code, ofType: "lproj")
            {
                return language
            }
            return "en-US"
        }
    }
    
    static var currentLanguageCode: String {
        get {
            if let language = preferredLanguages.first,
               let code = Locale(identifier: language).languageCode,
               let _ = Bundle.main.path(forResource: language, ofType: "lproj") ?? Bundle.main.path(forResource: code, ofType: "lproj")
            {
                return code
            }
            return "en"
        }
    }
    
}
