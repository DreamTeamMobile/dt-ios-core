//
//  Control.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

open class Control : Codable {
    
    public let text: [String: String]?

    public let theme: Theme?
    
    public init(text: [String : String]?, theme: Control.Theme?) {
        self.text = text
        self.theme = theme
    }
    
    open class Theme : Codable {
        
        public let tintColor: Color?

        public let delay: Int?

        public init(tintColor: Control.Theme.Color?, delay: Int?) {
            self.tintColor = tintColor
            self.delay = delay
        }
        
        open class Color : Codable {
            
            public let any: String

            public let dark: String?
            
            public init(any: String, dark: String?) {
                self.any = any
                self.dark = dark
            }

        }
        
    }

}


