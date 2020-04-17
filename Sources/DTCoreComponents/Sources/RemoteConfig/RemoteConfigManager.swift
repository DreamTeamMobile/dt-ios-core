//
//  RemoteConfigManager.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import FirebaseRemoteConfig

open class RemoteConfigManager: NSObject, RemoteConfigProtocol {
        
    public var expirationTimeoutInSeconds: TimeInterval = 300 // 5 minutes
        
    // MARK: Methods
    
    public func getSettings<T: Decodable>(key: String, version: String, suffix: String? = nil) -> T {
        let remoteConfig = RemoteConfig.remoteConfig()
        var fullKey = key
        if let s = suffix {
            fullKey = fullKey + s
        }
        var settings: T = deserialize(from: defaultConfig(from: fullKey) ?? "", to: T.self)!
        if let stringValue = (remoteConfig.configValue(forKey: version.isEmpty ? fullKey : "\(fullKey)_\(version)").stringValue) {
            if let model = deserialize(from: stringValue, to: T.self) {
                settings = model
            }
        }
        return settings
    }
    
    public func getSettings<T: Decodable>(version: String, suffix: String? = nil) -> T {
        return self.getSettings(
            key: String(describing: T.self).firstLowercased(),
            version: version,
            suffix: suffix)
    }
    
    public func fetch(with completion: (() -> Void)?) {
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.fetch(withExpirationDuration: expirationTimeoutInSeconds, completionHandler: { (status, error) in
            if (error == nil && status == RemoteConfigFetchStatus.success) {
                RemoteConfig.remoteConfig().activate { (error) in
                    completion?()
                }
            } else if let e = error {
                print(e)
                completion?()
            }
        })
    }
    
    public func fetchAndActivate(with completion: (() -> Void)?) {
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.fetchAndActivate { (status, error) in
            if (error == nil && status != .error) {
                completion?()
            } else if let e = error {
                print(e)
                completion?()
            }
        }
    }
    
}

private extension RemoteConfigManager {
    
    func defaultConfig(from fileName: String) -> String? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            if let string = try? String(contentsOfFile: path) {
                return string
            }
        }
        return nil
    }
    
    func deserialize<T>(from string: String, to model: T.Type) -> T? where T: Decodable {
        if let data = string.data(using: .utf8) {
            let decoder = JSONDecoder()
            do {
                return try decoder.decode(model, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
