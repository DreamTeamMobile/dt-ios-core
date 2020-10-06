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

    private var listeners: [UUID: Listener] = [:]
    
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
    
    deinit {
        self.listeners = [:]
    }
    
    // MARK: Private methods

    private func setListener(_ listener: @escaping Listener) {
        self.listeners.removeAll()
        self.listeners[UUID()] = listener
    }

    private func addListener(_ listener: @escaping Listener) -> UUID {
        let uuid = UUID()
        self.listeners[uuid] = listener
        return uuid
    }

    private func removeListener(_ uuid: UUID) {
        self.listeners.removeValue(forKey: uuid)
    }
        
    private func _fire(_ oldValue: T, force: Bool) {
        let value = self.wrappedValue
        if self.notifyOnEachChange || oldValue != value || force {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.listeners.forEach { $0.value(oldValue, value) }
            }
        }
    }
    
    // MARK: Methods
        
    public func fire(_ oldValue: T) {
        _fire(oldValue, force: false)
    }
    
    public func bind(_ listener: @escaping Listener) {
        setListener(listener)
    }

    public func bindAndFire(_ listener: @escaping Listener) {
        setListener(listener)
        _fire(self.wrappedValue, force: true)
    }
    
    public func subscribe(_ listener: @escaping Listener) -> UUID {
        return addListener(listener)
    }

    public func unsubscribe(_ uuid: UUID) {
        removeListener(uuid)
    }

}
