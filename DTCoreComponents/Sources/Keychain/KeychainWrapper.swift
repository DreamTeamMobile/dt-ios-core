//
//  KeychainWrapper.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import KeychainAccess

@propertyWrapper
public struct KeychainWrapper<T: LosslessStringConvertible> {
    
    let key: String
    let defaultValue: T

    public init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get {
            let keychain = KeychainAccess.Keychain()
            return T.init(keychain[key] ?? "") ?? defaultValue
        }
        set {
            let keychain = KeychainAccess.Keychain()
            keychain[key] = String(newValue)
        }
    }
    
}

