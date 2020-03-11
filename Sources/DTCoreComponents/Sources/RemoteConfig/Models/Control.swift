//
//  Control.swift
//  fitnesslab
//
//  Created by Максим Евтух on 11.03.2020.
//  Copyright © 2020 DreamTeamMobile. All rights reserved.
//

import Foundation

open class Control : Codable {
    
    let text: [String: String]?

    let theme: Theme?
    
    open class Theme : Codable {

        let tintColor: Color?

        let delay: Int?

        open class Color : Codable {

            let any: String

            let dark: String?

        }
        
    }

}


