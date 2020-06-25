//
//  LabelFrame.swift
//  
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public class LabelFrame: Frame {
    
    @BindableEquatable("", false)
    public var text: String
    
    override init() {
        super.init()
    }
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
}
