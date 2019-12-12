//
//  ButtonFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

protocol ButtonProtocol {
    
    var title: String { get set }
    
    var isSelected: Bool { get set }
    
    func execute(_ parameter: AnyObject?)
    
}

class ButtonFrame: NSObject, ButtonProtocol {
    
    // MARK: Fields
    
    private let onExecute: () -> Void
    
    // MARK: Properties
    
    @Bindable("") var title: String
    
    @Bindable(false) var isSelected: Bool
        
    @Bindable(false) var isHidden: Bool
    
    @Bindable(true) var enabled: Bool
    
    // MARK: Init
    
    convenience init(title: String, onExecute: @escaping () -> Void) {
        self.init(onExecute: onExecute)
        self.title = title
    }
        
    init(onExecute: @escaping () -> Void) {
        self.onExecute = onExecute
        super.init()
        self.title = ""
    }
    
    // MARK: Methods
    
    @objc func execute(_ parameter: AnyObject?) {
        self.onExecute()
    }
}

class TButtonFrame<T>: NSObject, ButtonProtocol {
    
    // MARK: Fields
    
    private let onExecute: (T) -> Void
    
    // MARK: Properties
    
    @Bindable("") var title: String
    
    @Bindable(false) var isSelected: Bool
    
    @Bindable(false) var isHidden: Bool
        
    // MARK: Init
        
    init(onExecute: @escaping (T) -> Void) {
        self.onExecute = onExecute
        super.init()
    }
    
    // MARK: Methods
    
    func execute(_ parameter: AnyObject?) {
        if let value = parameter as? T {
            self.onExecute(value)
        }
    }
}
