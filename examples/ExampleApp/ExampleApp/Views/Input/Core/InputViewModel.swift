//
//  InputViewModel.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation
import DT_Core_iOS

class InputViewModel: BaseViewModel<InputInitObj> {
    
    // MARK: Properties
    
    private(set) var inputFrame: InputFrame!
    
    private(set) var checkboxFrame: CheckboxFrame!
    
    private(set) var buttonFrame: ButtonFrame!
    
    // MARK: Init
    
    required init() {
        super.init()
        self.inputFrame = InputFrame(onTextChanged: self.onTextChanged, textValidator: nil)
        self.checkboxFrame = CheckboxFrame(value: false, onValueChanged: self.onValueChanged)
    }
    
    // MARK: Private methods
    
    private func updateButton() {
        self.buttonFrame.enabled = !self.inputFrame.text.isEmpty && self.checkboxFrame.isSelected
    }
    
    private func onTextChanged(_ text: String) {
        updateButton()
    }
    
    private func onValueChanged(_ value: Bool) {
        updateButton()
    }
}
