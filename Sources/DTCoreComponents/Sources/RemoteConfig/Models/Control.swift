//
//  Control.swift
//  fitnesslab
//
//  Created by Максим Евтух on 11.03.2020.
//  Copyright © 2020 DreamTeamMobile. All rights reserved.
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


