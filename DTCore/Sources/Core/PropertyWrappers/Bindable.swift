//
//  Bindable.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

@propertyWrapper
public class Bindable<T> {

    // MARK: Type aliases

    public typealias Listener = (_ oldValue: T, _ newValue: T) -> Void

    // MARK: Fields

    private var listeners: [UUID: Listener] = [:]

    // MARK: Properties

    public var wrappedValue: T {
        didSet {
            fire(oldValue)
        }
    }

    public var projectedValue: Bindable {
        self
    }

    // MARK: Init

    public init(
        _ v: T
    ) {
        self.wrappedValue = v
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

    // MARK: Methods

    public func fire(_ oldValue: T) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.listeners.forEach { $0.value(oldValue, self.wrappedValue) }
        }
    }

    public func bind(_ listener: @escaping Listener) {
        setListener(listener)
    }

    public func bindAndFire(_ listener: @escaping Listener) {
        setListener(listener)
        fire(self.wrappedValue)
    }

    public func subscribe(_ listener: @escaping Listener) -> UUID {
        return addListener(listener)
    }

    public func unsubscribe(_ uuid: UUID) {
        removeListener(uuid)
    }

}

public func bind<T>(_ value: T) -> Bindable<T> {
    return Bindable<T>(value)
}
