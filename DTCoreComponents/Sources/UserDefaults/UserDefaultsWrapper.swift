//
//  UserDefaultsWrapper.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UserDefault<T> {
    let key: String
    let defaultValue: T

    public init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }

}

@propertyWrapper
public struct OptionalUserDefault<T> {
    let storage = UserDefaults.standard
    let key: String
    

    public init(key: String) {
        self.key = key
    }
    
    public var wrappedValue: T? {
        get { storage.object(forKey: key) as? T }
        set { storage.set(newValue, forKey: key) }
    }
}
