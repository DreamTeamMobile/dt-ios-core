//
//  Device.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

public class Device: NSObject {
    
    public class var current: DeviceModel {
        get {
            if UIDevice.current.userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    return .iPhoneSE
                    
                case 1334:
                    return .iPhone
                    
                case 1920, 2208:
                    return .iPhonePlus
                    
                case 2436:
                    return .iPhoneX
                    
                case 2688:
                    return .iPhoneXMax
                    
                case 1792:
                    return .iPhoneXr
                    
                default:
                    return .unknown
                }
            }
            return .unknown
        }
    }
        
    public class var devicesGroup: DevicesGroup {
        switch self.current {
        case .iPhoneSE:
            return .small
        case .iPhone: fallthrough
        case .iPhoneX:
            return .normal
        case .iPhonePlus: fallthrough
        case .iPhoneXMax: fallthrough
        case .iPhoneXr:
            return .large
        case .unknown:
            return .large
        }
    }
    
    public class func deviceName(modelName: String) -> String {
        return devicesDictionary[modelName] ?? modelName
    }
    
}
