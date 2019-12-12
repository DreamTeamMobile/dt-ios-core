//
//  UIViewController+Extensions.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    class var nibName: String {
        return String(describing: self)
    }
    
}
