//
//  BindableButton+Extensions.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

extension UISwitch {
    
    public func bind(_ frame: SwitchFrame) {
        frame.$isOn.bindAndFire { [weak self] oldValue, newValue in
            self?.isOn = newValue
        }
        frame.$isHidden.bindAndFire { [weak self] oldValue, newValue in
            self?.isHidden = newValue
        }
        frame.$enabled.bindAndFire { [weak self] oldValue, newValue in
            self?.isEnabled = newValue
        }
        
        self.removeTarget(nil, action: nil, for: .valueChanged)
        self.addTarget(frame, action: #selector(frame.onValueChanged), for: .valueChanged)
    }
    
}
