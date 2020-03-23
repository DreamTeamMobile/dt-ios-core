//
//  Product.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
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
    
    open class Price : Codable {
        public let normal: [String: String]
        public let trial: [String: String]?
    }
}
