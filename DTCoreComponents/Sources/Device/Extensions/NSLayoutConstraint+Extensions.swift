//
//  NSLayoutConstraint+Extensions.swift
//  DTCoreComponents
//
//  Created by Максим Евтух on 09.06.2021.
//  Copyright © 2021 DreamTeam. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint {
    
    func setUp(by groups: [DevicesGroup: CGFloat]) {
        self.constant = self.constant.setUp(by: groups)
    }
    
    func setUp(by models: [DeviceModel: CGFloat]) {
        self.constant = self.constant.setUp(by: models)
    }
    
}
