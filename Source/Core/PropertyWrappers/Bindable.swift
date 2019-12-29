//
//  Bindable.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

@propertyWrapper
public class Bindable<T> {

    // MARK: Type aliases
    
    public typealias Listener = (_ oldValue: T, _ newValue: T) -> ()
    
    // MARK: Fields
    
    private var listener: Listener?
    
    // MARK: Properties
    
    public var wrappedValue: T {
        didSet {
            fire(oldValue)
        }
    }

    public var projectedValue : Bindable {
        self
    }

    // MARK: Init
    
    public init(_ v: T) {
        self.wrappedValue = v
    }
    
    deinit {
        self.listener = nil
    }
    
    // MARK: Methods
        
    public func fire(_ oldValue: T) {
        let value = wrappedValue
        DispatchQueue.main.async {[weak self] in
            self?.listener?(oldValue, value)
        }
    }
    
    public func bind(_ listener: Listener?) {
        self.listener = listener
    }

    public func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        fire(self.wrappedValue)
    }

}

public func bind<T>(_ value: T) -> Bindable<T> {
    return Bindable<T>(value)
}
