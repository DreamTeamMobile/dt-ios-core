//
//  SwitchFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import UIKit

public class SwitchFrame: NSObject {
    
    // MARK: Fields
    
    private var valueChanged: (Bool) -> Void
    
    // MARK: Properties
    
    @BindableEquatable(false, false)
    public var isOn: Bool {
        didSet {
            if oldValue != self.isOn {
                self.valueChanged(self.isOn)
            }
        }
    }
    
    // MARK: Init
    
    public init(value: Bool) {
        self.valueChanged = { _ in }
        super.init()
        self.isOn = value
    }
    
    public init(value: Bool, onValueChanged: @escaping (Bool) -> Void) {
        self.valueChanged = { _ in }
        super.init()
        self.isOn = value
        self.valueChanged = onValueChanged
    }
    
}

public extension SwitchFrame {
        
    @objc public func onValueChanged(_ sender: UISwitch) {
        self.isOn = sender.isOn
    }
    
}
