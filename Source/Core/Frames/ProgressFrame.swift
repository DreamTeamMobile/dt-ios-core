//
//  ProgressFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public class ProgressFrame: NSObject {
 
    @Bindable(0) var currentProgress: Float
    
    @Bindable(0) var minProgress: Float
    
    @Bindable(1) var maxProgress: Float
    
}
