//
//  NavigationControllerHolder.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

public class NavigationControllerHolder: NSObject, NavigationControllerHolderProtocol {
    
    // MARK: Properties
    
    private var currentNavigationController: UINavigationController?
    
    // MARK: NavigationControllerHolderProtocol implementation
    
    public func setCurrentNavigationController(_ navigationController: UINavigationController?) {
        if let nc = navigationController {
            self.currentNavigationController = nc
        }
    }
    
    public func getCurrentNavigationController() -> UINavigationController? {
        return self.currentNavigationController
    }
    
}
