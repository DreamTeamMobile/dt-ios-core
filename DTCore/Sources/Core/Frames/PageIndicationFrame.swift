//
//  PageIndicationFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public class PageIndicationFrame: Frame {
    
    // MARK: Properties
    
    @Bindable(0)
    public var currentPage: Int
    
    @Bindable(0)
    public var pagesCount: Int
    
    @Bindable(0)
    public var pageProgress: Float
    
}
