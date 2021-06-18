//
//  SwitchFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import UIKit

public class SwitchFrame: Frame {
    
    // MARK: Fields
    
    private var valueChanged: ((Bool) -> Void)?
    
    // MARK: Properties
    
    @BindableEquatable(false, false)
    public var isOn: Bool {
        didSet {
            if oldValue != self.isOn {
                self.valueChanged?(self.isOn)
            }
        }
    }
    
    @Bindable(true)
    public var enabled: Bool
    
    // MARK: Init
    
    public init(value: Bool) {
        super.init()
        self.isOn = value
    }
    
    public init(value: Bool, onValueChanged: ((Bool) -> Void)?) {
        super.init()
        
        self.isOn = value
        self.valueChanged = onValueChanged
    }
    
}

public extension SwitchFrame {
        
    @objc func onValueChanged(_ sender: UISwitch) {
        self.isOn = sender.isOn
    }
    
}
