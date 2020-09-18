//
//  Locale+Extensions.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public extension Locale {
    
    static var currentLanguage: String {
        get {
            let defaultLanguage = "en-US"
            
            guard let language = preferredLanguages.first else { return defaultLanguage }
            let locale = Locale(identifier: language)
            
            guard let code = locale.languageCode else { return defaultLanguage }
            
            if let _ = Bundle.main.path(forResource: language, ofType: "lproj") ?? Bundle.main.path(forResource: code, ofType: "lproj") {
                return language
            } else if let scriptCode = locale.scriptCode,
                let _ = Bundle.main.path(forResource: "\(code)-\(scriptCode)", ofType: "lproj") {
                return language
            }
            
            return defaultLanguage
        }
    }
    
    static var currentLanguageCode: String {
        get {
            let defaultCode = "en"
            
            guard let language = preferredLanguages.first else { return defaultCode }
            let locale = Locale(identifier: language)
            
            guard let code = locale.languageCode else { return defaultCode }
            
            if let _ = Bundle.main.path(forResource: language, ofType: "lproj") ?? Bundle.main.path(forResource: code, ofType: "lproj") {
                return code
            } else if let scriptCode = locale.scriptCode,
                let _ = Bundle.main.path(forResource: "\(code)-\(scriptCode)", ofType: "lproj") {
                return code
            }
            
            return defaultCode
        }
    }
    
}
