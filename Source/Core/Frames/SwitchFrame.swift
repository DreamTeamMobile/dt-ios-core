//
//  SwitchFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import UIKit

class SwitchFrame: NSObject {
    
    // MARK: Fields
    
    private var valueChanged: (Bool) -> Void
    
    // MARK: Properties
    
    @BindableEquatable(false, false) var isOn: Bool {
        didSet {
            if oldValue != self.isOn {
                self.valueChanged(self.isOn)
            }
        }
    }
    
    // MARK: Init
    
    init(value: Bool) {
        self.valueChanged = { _ in }
        super.init()
        self.isOn = value
    }
    
    init(value: Bool, onValueChanged: @escaping (Bool) -> Void) {
        self.valueChanged = { _ in }
        super.init()
        self.isOn = value
        self.valueChanged = onValueChanged
    }
    
}

extension SwitchFrame {
        
    @objc func onValueChanged(_ sender: UISwitch) {
        self.isOn = sender.isOn
    }
    
}
