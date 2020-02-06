//
//  InteractionProtocol.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public protocol InteractionProtocol {
    
    func copyToClipboard(_ text: String)
    
    func shareText(_ text: String)
    
    func share(_ activityItems: [Any])
    
    func openUrl(_ link: String) -> Bool
        
    func createEmail(email: String) -> Bool
    
    func composeEmail(email: String, subject: String, body: String)
    
    func composeSupportEmail(email: String)
    
    func changeIcon(_ name: String)
    
}
