//
//  RemoteConfigProtocol.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public protocol RemoteConfigProtocol {
 
    var expirationTimeoutInSeconds: TimeInterval { get set }
    
    func getSettings<T: Decodable>(version: String, suffix: String? = nil) -> T
    
    func fetch(with completion: (() -> Void)?)
    
}
