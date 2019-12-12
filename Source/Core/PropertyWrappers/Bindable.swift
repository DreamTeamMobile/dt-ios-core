//
//  Bindable.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

@propertyWrapper
class Bindable<T> {

    // MARK: Type aliases
    
    typealias Listener = (_ oldValue: T, _ newValue: T) -> ()
    
    // MARK: Fields
    
    private var listener: Listener?
    
    // MARK: Properties
    
    var wrappedValue: T {
        didSet {
            fire(oldValue)
        }
    }

    var projectedValue : Bindable {
        self
    }

    // MARK: Init
    
    init(_ v: T) {
        self.wrappedValue = v
    }
    
    deinit {
        self.listener = nil
    }
    
    // MARK: Methods
        
    func fire(_ oldValue: T) {
        let value = wrappedValue
        DispatchQueue.main.async {[weak self] in
            self?.listener?(oldValue, value)
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

func bind<T>(_ value: T) -> Bindable<T> {
    return Bindable<T>(value)
}
