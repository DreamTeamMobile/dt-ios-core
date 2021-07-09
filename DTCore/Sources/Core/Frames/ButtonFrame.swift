//
//  ButtonFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public protocol ButtonProtocol {
    
    var title: String { get set }
    
    var isSelected: Bool { get set }
    
    func execute(_ parameter: Any?)
    
}

public class ButtonFrame: Frame, ButtonProtocol {
    
    // MARK: Fields
    
    private let onExecute: () -> Void
    
    // MARK: Properties
    
    @Bindable("") public var title: String
    
    @Bindable(false) public var isSelected: Bool
            
    @Bindable(true) public var enabled: Bool
    
    // MARK: Init
    
    convenience public init(title: String, onExecute: @escaping () -> Void) {
        self.init(onExecute: onExecute)
        self.title = title
    }
        
    public init(onExecute: @escaping () -> Void) {
        self.onExecute = onExecute
        super.init()
        self.title = ""
    }
    
    // MARK: Methods
    
    @objc public func execute(_ parameter: Any?) {
        self.onExecute()
    }
}

public class TButtonFrame<T>: Frame, ButtonProtocol {
    
    // MARK: Fields
    
    private let onExecute: (T) -> Void
    
    // MARK: Properties
    
    @Bindable("") public var title: String
    
    @Bindable(false) public var isSelected: Bool
            
    // MARK: Init
        
    public init(onExecute: @escaping (T) -> Void) {
        self.onExecute = onExecute
        super.init()
    }
    
    // MARK: Methods
    
    public func execute(_ parameter: Any?) {
        if let value = parameter as? T {
            self.onExecute(value)
        }
    }
}
