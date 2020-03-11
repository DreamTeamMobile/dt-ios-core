//
//  Product.swift
//  fitnesslab
//
//  Created by Максим Евтух on 11.03.2020.
//  Copyright © 2020 DreamTeamMobile. All rights reserved.
//

import Foundation

open class Product : Codable {
    
    public let id: String
    public let productId: String
    public let title: [String: String]?
    public let subtitle: [String: String]?
    public let price: Price?
    public let trial: [String: String]?
    public let promotion: [String: String]?
    
    struct Price : Codable {
        public let normal: [String: String]
        public let trial: [String: String]?
    }
}
