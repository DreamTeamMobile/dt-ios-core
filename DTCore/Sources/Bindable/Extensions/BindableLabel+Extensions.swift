//
//  BindableLabel+Extensions.swift
//  
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

extension UILabel {
    
    public func bind(_ frame: LabelFrame) {
        frame.$text.bindAndFire { [weak self] oldValue, newValue in
            self?.text = newValue
        }
        frame.$isHidden.bindAndFire { [weak self] oldValue, newValue in
            self?.isHidden = newValue            
        }
    }
    
}
