//
//  UIApplication+Extensions.swift
//  DTCore
//
//  Created by Максим Евтух on 18.06.2021.
//  Copyright © 2021 DreamTeam. All rights reserved.
//

import UIKit

public extension UIApplication {
    
    class func getCurrentViewController(base: UIViewController? = UIApplication.shared.windows.first(where: \.isKeyWindow)?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getCurrentViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getCurrentViewController(base: selected)            
        } else if let presented = base?.presentedViewController {
            return getCurrentViewController(base: presented)
        }
        return base
    }
    
    class func getLastPresentedControllerFor(_ viewController: UIViewController? = UIApplication.shared.windows.first(where: \.isKeyWindow)?.rootViewController) -> UIViewController? {
        if let presented = viewController?.presentedViewController {
            return getLastPresentedControllerFor(presented)
        }
        
        return viewController
    }
    
    class func getLastPresentedControllerFor<ViewModel: BViewModel>(_ viewController: UIViewController? = UIApplication.shared.windows.first(where: \.isKeyWindow)?.rootViewController, _ vmType: ViewModel.Type) -> UIViewController? {
        if let presented = viewController?.presentedViewController {
            if let bViCo = presented as? BaseViCoProtocol, let _ = bViCo.getViewModel() as? ViewModel {
                return presented
            }
            return getLastPresentedControllerFor(presented)
        }
        
        return viewController
    }
    
}
