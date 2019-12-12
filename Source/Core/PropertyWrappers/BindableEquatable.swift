//
//  BindableEquatable.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

@propertyWrapper
public class BindableEquatable<T: Equatable> {

    // MARK: Type aliases
    
    typealias Listener = (_ oldValue: T, _ newValue: T) -> ()
    
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
    
    convenience init(_ v: T) {
        self.init(v, true)
    }
    
    init (_ v: T, _ notifyOnEachChange: Bool) {
        self.wrappedValue = v
        self.notifyOnEachChange = notifyOnEachChange
    }
    
    // MARK: Methods
        
    func fire(_ oldValue: T) {
        let value = wrappedValue
        if let action = self.listener {
            if self.notifyOnEachChange || (!self.notifyOnEachChange && oldValue != value) {
                DispatchQueue.main.async { action(oldValue, value) }
            }
        }
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        fire(self.wrappedValue)
    }

}
