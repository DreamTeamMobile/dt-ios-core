//
//  Numbers+Extensions.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

public extension CGFloat {
    
    func setUp(by groups: [DevicesGroup: CGFloat]) -> CGFloat {
        guard let value = groups[Device.devicesGroup] else { return self }
        
        return value
    }
    
    func setUp(by models: [DeviceModel: CGFloat]) -> CGFloat {
        guard let value = models[Device.current] else { return self }
        
        return value
    }
    
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
    
    func isSmall(_ value: CGFloat) -> CGFloat {
        return Device.devicesGroup == .small ? value : self
    }
    
    func isNormal(_ value: CGFloat) -> CGFloat {
        return Device.devicesGroup == .normal ? value : self
    }
    
    func isLarge(_ value: CGFloat) -> CGFloat {
        return Device.devicesGroup == .large ? value : self
    }
    
}
