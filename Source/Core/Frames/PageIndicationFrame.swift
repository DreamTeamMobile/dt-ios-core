//
//  PageIndicationFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public class PageIndicationFrame: NSObject {
    
    // MARK: Properties
    
    @Bindable(0) var currentPage: Int {
        didSet {
            print("currentPage: \(currentPage)")
        }
    }
    
    @Bindable(0) var pagesCount: Int {
        didSet {
            print("pagesCount: \(pagesCount)")
        }
    }
    
    @Bindable(0) var pageProgress: Float {
        didSet {
            print("pageProgress: \(pageProgress)")
        }
    }
    
}
