//
//  CheckboxFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public class CheckboxFrame: Frame {
    
    // MARK: Fields
    
    private var valueChanged: (Bool) -> Void
    
    // MARK: Properties
    
    @BindableEquatable(false, false)
    public var isSelected: Bool {
        didSet {
            if oldValue != self.isSelected {
                self.valueChanged(self.isSelected)
            }
        }
    }
    
    @Bindable("")
    public var text: String
        
    // MARK: Init
    
    // MARK: Init
    
    public init(value: Bool) {
        self.valueChanged = { _ in }
        super.init()
        self.text = ""
        self.isSelected = value
    }
    
    public init(value: Bool, onValueChanged: @escaping (Bool) -> Void) {
        self.valueChanged = { _ in }
        super.init()
        self.text = ""
        self.isSelected = value
        self.valueChanged = onValueChanged
    }
    
    // MARK: Methods
    
    public func toggle() {
        self.isSelected = !self.isSelected
    }
}
