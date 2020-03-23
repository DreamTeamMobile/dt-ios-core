//
//  Control.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

open class Control : Codable {
    
    public let text: [String: String]?

    public let theme: Theme?
    
    open class Theme : Codable {

        public let tintColor: Color?

        public let delay: Int?

        open class Color : Codable {

            public let any: String

            public let dark: String?

        }
        
    }

}


