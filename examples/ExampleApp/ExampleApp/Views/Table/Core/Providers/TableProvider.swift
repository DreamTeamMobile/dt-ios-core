//
//  TableProvider.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import Fakery

class TableProvider: TableProviderProtocol {
    
    // MARK: Fields
    
    private let itemsCount: Int = 30
    
    private let array: [String]
    
    // MARK: Init
    
    init() {
        var arr = [String]()
        let faker = Faker()
        for _ in 0..<itemsCount {
            arr.append(faker.address.city())
        }
        self.array = arr
    }
    
    // MARK: Methods
    
    func getItems(searchRequest: String) -> [String] {
        return searchRequest.isEmpty
            ? array
            : array.filter { $0.contains(searchRequest) }
    }
    
}
