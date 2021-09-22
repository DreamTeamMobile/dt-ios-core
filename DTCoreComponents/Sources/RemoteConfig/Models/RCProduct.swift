//
//  Product.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

open class RCProduct : Codable {
    
    public let id: String
    public let productId: String
    public let title: [String: String]?
    public let subtitle: [String: String]?
    public let price: Price?
    public let trial: [String: String]?
    public let promotion: [String: String]?
    
    public init(id: String, productId: String, title: [String : String]?, subtitle: [String : String]?, price: RCProduct.Price?, trial: [String : String]?, promotion: [String : String]?) {
        self.id = id
        self.productId = productId
        self.title = title
        self.subtitle = subtitle
        self.price = price
        self.trial = trial
        self.promotion = promotion
    }
    
    open class Price : Codable {
        public let normal: [String: String]
        public let trial: [String: String]?
        
        public init(normal: [String : String], trial: [String : String]?) {
            self.normal = normal
            self.trial = trial
        }
    }
}
