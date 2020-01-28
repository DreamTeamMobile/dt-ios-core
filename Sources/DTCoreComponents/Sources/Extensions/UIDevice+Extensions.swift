//
//  UIDevice+Extensions.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

public extension UIDevice {

    static var hasNotch: Bool {
        guard let window = UIApplication.shared.keyWindow else {
            return false
        }
        let inset = window.safeAreaInsets.top
        if inset > 20.0 {
            return true
        }
        return false
    }

    static var safeAreaInsets: UIEdgeInsets? {
        guard let window = UIApplication.shared.keyWindow else {
            return nil
        }
        let insets = window.safeAreaInsets
        return insets
    }

    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return Device.deviceName(modelName: identifier)
    }
}
