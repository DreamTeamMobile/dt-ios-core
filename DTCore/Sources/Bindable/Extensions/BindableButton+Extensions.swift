//
//  BindableButton+Extensions.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

extension UIButton {
    
    public func bind(_ frame: ButtonFrame) {
        frame.$title.bindAndFire { [weak self] oldValue, newValue in
            self?.setTitle(newValue, for: .normal)
        }
        frame.$isHidden.bindAndFire { [weak self] oldValue, newValue in
            self?.isHidden = newValue
        }
        frame.$enabled.bindAndFire { [weak self] oldValue, newValue in
            self?.isEnabled = newValue
        }
        frame.$isSelected.bindAndFire { [weak self] oldValue, newValue in
            self?.isSelected = newValue
        }
        self.removeTarget(nil, action: nil, for: .touchUpInside)
        self.addTarget(frame, action: #selector(frame.execute), for: .touchUpInside)
    }
    
}
