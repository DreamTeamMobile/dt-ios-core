//
//  StoreReviewProtocol.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public protocol StoreReviewProtocol {
    
    var daysBetweenReviews: Int { get set }
    
    func resetLimits()
    
    func requestReview()
    
    func requestReviewIfNeeded()
    
}
