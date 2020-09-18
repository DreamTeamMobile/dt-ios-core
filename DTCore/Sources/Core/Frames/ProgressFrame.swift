//
//  ProgressFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public class ProgressFrame: Frame {
 
    @Bindable(0)
    public var currentProgress: Float
    
    @Bindable(0)
    public var minProgress: Float
    
    @Bindable(1)
    public var maxProgress: Float
    
}
