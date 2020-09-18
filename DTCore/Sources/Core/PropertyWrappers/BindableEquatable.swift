//
//  BindableEquatable.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

@propertyWrapper
public class BindableEquatable<T: Equatable> {

    // MARK: Type aliases
    
    public typealias Listener = (_ oldValue: T, _ newValue: T) -> ()
    
    // MARK: Fields
    
    private var listener: Listener?
    
    // MARK: Properties
    
    private(set) var notifyOnEachChange: Bool
    
    public var wrappedValue: T {
        didSet {
            fire(oldValue)
        }
    }

    public var projectedValue : BindableEquatable {
        self
    }

    // MARK: Init
    
    convenience public init(_ v: T) {
        self.init(v, true)
    }
    
    public init (_ v: T, _ notifyOnEachChange: Bool) {
        self.wrappedValue = v
        self.notifyOnEachChange = notifyOnEachChange
    }
    
    // MARK: Private methods
    
    private func _fire(_ oldValue: T, force: Bool) {
        let value = wrappedValue
        if let action = self.listener {
            if self.notifyOnEachChange || oldValue != value || force {
                DispatchQueue.main.async { action(oldValue, value) }
            }
        }
    }
    
    // MARK: Methods
        
    public func fire(_ oldValue: T) {
        _fire(oldValue, force: false)
    }
    
    public func bind(_ listener: Listener?) {
        self.listener = listener
    }

    public func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        _fire(self.wrappedValue, force: true)
    }

}
