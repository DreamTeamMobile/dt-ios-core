//
//  CheckboxFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

class CheckboxFrame: NSObject {
    
    // MARK: Fields
    
    private var valueChanged: (Bool) -> Void
    
    // MARK: Properties
    
    @BindableEquatable(false, false) var isSelected: Bool {
        didSet {
            if oldValue != self.isSelected {
                self.valueChanged(self.isSelected)
            }
        }
    }
    
    @Bindable("") var text: String
        
    // MARK: Init
    
    // MARK: Init
    
    init(value: Bool) {
        self.valueChanged = { _ in }
        super.init()
        self.text = ""
        self.isSelected = value
    }
    
    init(value: Bool, onValueChanged: @escaping (Bool) -> Void) {
        self.valueChanged = { _ in }
        super.init()
        self.text = ""
        self.isSelected = value
        self.valueChanged = onValueChanged
    }
    
    // MARK: Methods
    
    func toggle() {
        self.isSelected = !self.isSelected
    }
}
