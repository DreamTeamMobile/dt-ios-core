//
//  TableProviderProtocol.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

protocol TableProviderProtocol {

    func getItems(searchRequest: String) -> [String]

}
