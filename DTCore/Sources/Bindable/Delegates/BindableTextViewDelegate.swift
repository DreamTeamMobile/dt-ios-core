//
//  BindableTextViewDelegate.swift
//  DTCore
//
//  Created by Максим Евтух on 01.07.2021.
//  Copyright © 2021 DreamTeam. All rights reserved.
//

import UIKit

open class BindableTextViewDelegate: NSObject, UITextViewDelegate {
    
    // MARK: Fields
    
    public let inputFrame: InputFrame
    
    public let textView: UITextView
    
    // MARK: Init
    
    public init(inputFrame: InputFrame, textView: UITextView) {
        self.inputFrame = inputFrame
        self.textView = textView
        
        super.init()
        
        setupBindings(inputFrame, textView)
    }
 
    // MARK: Private methods
    
    private func setupBindings(_ inputFrame: InputFrame, _ textView: UITextView) {
        self.textView.text = inputFrame.text
                
        inputFrame.$text.bindAndFire(self.onTextChanged)
        inputFrame.$isHidden.bindAndFire(self.onHiddenChanged)
    }
    
    private func onTextViewValueChanged(_ sender: UITextView) {
        self.inputFrame.text = sender.text ?? ""
    }
    
    private func onTextChanged(_ oldValue: String, _ newValue: String) {
        self.textView.text = newValue
    }
    
    private func onHiddenChanged(_ oldValue: Bool, _ newValue: Bool) {
        self.textView.isHidden = newValue
    }
    
    // MARK: Delegate implementation
    
    open func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }

    open func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }

    open func textViewDidBeginEditing(_ textView: UITextView) {
        
    }

    open func textViewDidEndEditing(_ textView: UITextView) {
        
    }

    open func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return self.inputFrame.shouldChangeCharactersIn(range: range, replacementString: text)
    }

    open func textViewDidChange(_ textView: UITextView) {
        onTextViewValueChanged(textView)
    }

    open func textViewDidChangeSelection(_ textView: UITextView) {
        
    }

    open func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }

    open func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }

    open func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        return true
    }

    open func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool {
        return true
    }
}
