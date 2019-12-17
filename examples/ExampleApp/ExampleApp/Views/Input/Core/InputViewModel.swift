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
    
    private(set) var switchFrame: SwitchFrame!
    
    private(set) var buttonFrame: ButtonFrame!
    
    // MARK: Init
    
    required init() {
        super.init()
        self.inputFrame = InputFrame(onTextChanged: self.onTextChanged, textValidator: nil)
        self.switchFrame = SwitchFrame(value: false, onValueChanged: self.onValueChanged)
        self.buttonFrame = ButtonFrame(onExecute: self.onButtonExecute)
    }
    
    // MARK: Private methods
    
    private func updateButton() {
        self.buttonFrame.enabled = !self.inputFrame.text.isEmpty && self.switchFrame.isOn
    }
    
    private func onTextChanged(_ text: String) {
        updateButton()
    }
    
    private func onValueChanged(_ value: Bool) {
        updateButton()
    }
    
    private func onButtonExecute() {
        
    }
}
