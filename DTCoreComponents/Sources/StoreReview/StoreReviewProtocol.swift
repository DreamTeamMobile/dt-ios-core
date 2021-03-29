//
//  StoreReviewProtocol.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public protocol StoreReviewProtocol {
    
    var daysBetweenReviews: Int { get set }
    
    /// - Parameters:
    ///   - appID: Application ID in the AppStore
    ///   - completion: The block to execute with the results. Provide a value for this parameter if you want to be informed of the success or failure of opening the URL. This block is executed asynchronously on your app's main thread. The block has no return value and takes the following parameter:
    ///     - success – A Boolean indicating whether the URL was opened successfully.
    func writeReview(appID: String, completion: ((Bool) -> Void)?) -> Bool
    
    func resetLimits()
    
    func requestReview()
    
    func requestReviewIfNeeded()
    
}
