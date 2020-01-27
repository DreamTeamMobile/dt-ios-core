//
//  Device.swift
//  stickercreator
//
//  Created by Максим Евтух on 19/06/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import UIKit

class Device: NSObject {
    
    class var current: DeviceModel {
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
        
    class var devicesGroup: DevicesGroup {
        switch self.current {
        case .iPhoneSE
            return .small
        case .iPhone: fallthrough
        case .iPhoneX:
            return .normal
        case .iPhoneXMax: fallthrough
        case .iPhoneXr:
            return .large
        }
    }
    
    class func deviceName(modelName: String) -> String {
        return devicesDictionary[modelName] ?? modelName
    }
}
