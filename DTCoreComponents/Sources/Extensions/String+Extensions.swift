//
//  String+Extensions.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public extension String {
    
    func firstLowercased() -> String {
        let character = self[self.startIndex]
        return self.replacingCharacters(
            in: self.rangeOfComposedCharacterSequence(at: self.startIndex),
            with: character.lowercased())
    }
    
    func firstUppercased() -> String {
        let character = self[self.startIndex]
        return self.replacingCharacters(
            in: self.rangeOfComposedCharacterSequence(at: self.startIndex),
            with: character.uppercased())
    }
    
}
