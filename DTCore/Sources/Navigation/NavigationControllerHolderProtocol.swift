//
//  NavigationControllerHolderProtocol.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

public protocol NavigationControllerHolderProtocol {
    
    func setCurrentNavigationController(_ navigationController: UINavigationController?)
    
    func getCurrentNavigationController() -> UINavigationController?
    
}
