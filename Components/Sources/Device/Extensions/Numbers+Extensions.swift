//
//  CGFloat_Extensions.swift
//  Speech Keyboard
//
//  Created by Максим Евтух on 23.10.2019.
//  Copyright © 2019 Google. All rights reserved.
//

import UIKit

extension CGFloat {
    
    func isSeModel(_ value: CGFloat) -> CGFloat {
        return Device.current == .iPhoneSE ? value : self
    }
    
    func is8model(_ value: CGFloat) -> CGFloat {
        return Device.current == .iPhone ? value : self
    }
    
    func is8plusModel(_ value: CGFloat) -> CGFloat {
        return Device.current == .iPhonePlus ? value : self
    }
    
    func isXmodel(_ value: CGFloat) -> CGFloat {
        return Device.current == .iPhoneX ? value : self
    }
    
    func isXrModel(_ value: CGFloat) -> CGFloat {
        return Device.current == .iPhoneXr ? value : self
    }
    
    func isXmaxModel(_ value: CGFloat) -> CGFloat {
        return Device.current == .iPhoneXMax ? value : self
    }
    
}
