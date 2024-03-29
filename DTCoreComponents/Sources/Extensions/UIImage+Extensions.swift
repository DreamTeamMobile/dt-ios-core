//
//  UIImage+Extensions.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

public extension UIImage {
    
    static func imageWithDynamicProvider(named imageName: String, isDarkThemeEnabled: Bool) -> UIImage {
        if #available(iOS 13.0, *) {
            var image = UIImage()
            if UIApplication.shared.windows.first(where: \.isKeyWindow)?.rootViewController?.traitCollection.userInterfaceStyle == .dark || isDarkThemeEnabled {
                image = UIImage(named: imageName, in: nil, compatibleWith: UITraitCollection(userInterfaceStyle: .dark))!
            } else {
                image = UIImage(named: imageName, in: nil, compatibleWith: UITraitCollection(userInterfaceStyle: .light))!
            }
            return image
        }
        return UIImage(named: imageName)!
    }
    
    static func imageWithDynamicProvider(light: UIImage, dark: UIImage, isDarkThemeEnabled: Bool) -> UIImage {
        if #available(iOS 13.0, *) {
            if UIApplication.shared.windows.first(where: \.isKeyWindow)?.overrideUserInterfaceStyle == .dark || isDarkThemeEnabled {
                return dark
            }
            return light
        }
        return light
    }
    
}
