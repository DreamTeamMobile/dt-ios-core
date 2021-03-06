//
//  InputFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public class InputFrame: Frame {
    
    // MARK: Properties
    
    @BindableEquatable("", false)
    public var text: String {
        didSet {
            self.onTextChanged?(self.text)
        }
    }
    
    public var maxTextLength: Int? = nil
    
    public var onTextChanged: ((String) -> Void)?
    
    public var textValidator: ((String) -> Bool)?
    
    // MARK: Init
    
    override public init() {
        
    }
    
    public init(onTextChanged: ((String) -> Void)?, textValidator: ((String) -> Bool)?) {
        self.onTextChanged = onTextChanged
        self.textValidator = textValidator
    }
    
    // MARK: Private methods
    
    private func getNewText(_ range: NSRange, _ userText: String, _ text: String) -> String {
        var newText = ""
        if range.length > 0 {
            let txt = NSString(string: userText)
            if txt.length > 0 {
                newText = txt.replacingCharacters(in: range, with: text)
            }
        } else {
            newText = userText + text
        }
        return newText
    }
    
    // MARK: Methods
    
    public func shouldChangeCharactersIn(range: NSRange, replacementString text: String) -> Bool {
        let currentText = self.text
        var newText = getNewText(range, currentText, text)
        
        guard let maxTextLength = self.maxTextLength else {
            return self.textValidator?(newText) ?? true
        }
        
        let result = newText.count <= maxTextLength
        
        if !result && currentText.count - range.length < maxTextLength {
            var availableCount = maxTextLength - currentText.count + range.length
            availableCount = availableCount > text.count ? text.count : availableCount
            newText = getNewText(range, currentText,  String(text[..<text.index(text.startIndex, offsetBy: availableCount)]))
            self.text = newText
        }
        
        let isValid = self.textValidator?(newText) ?? true
        
        return result && isValid
    }
}
