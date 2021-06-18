//
//  BindableButton+Extensions.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

extension UITapGestureRecognizer {
    
    public func bind(frame: ButtonFrame) {
        frame.$enabled.bindAndFire { [weak self] oldValue, newValue in
            self?.isEnabled = newValue
        }
        
        self.removeTarget(nil, action: nil)
        self.addTarget(frame, action: #selector(frame.execute(_:)))
    }
    
}
