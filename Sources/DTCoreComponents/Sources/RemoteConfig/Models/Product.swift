//
//  Product.swift
//  fitnesslab
//
//  Created by Максим Евтух on 11.03.2020.
//  Copyright © 2020 DreamTeamMobile. All rights reserved.
//

import Foundation

open class Product : Codable {
    
    let id: String
    let productId: String
    let title: [String: String]?
    let subtitle: [String: String]?
    let price: Price?
    let trial: [String: String]?
    let promotion: [String: String]?
    
    struct Price : Codable {
        let normal: [String: String]
        let trial: [String: String]?
    }
}
