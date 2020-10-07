//
//  MultipleViewModel.swift
//  ExampleApp
//
//  Created by Максим Евтух on 06.10.2020.
//  Copyright © 2020 DreamTeam Apps. All rights reserved.
//

import DTCore

class MultipleViewModel: BaseViewModel<MultipleInitObject> {

    // MARK: Frames

    private(set) var inputFrame: InputFrame!

    private(set) var enteredText: LabelFrame!

    // MARK: Init

    required init() {
        super.init()
        self.inputFrame = InputFrame(onTextChanged: { [weak self] txt in self?.onTextChanged(txt) }, textValidator: nil)
        self.enteredText = LabelFrame()
    }
    
    // MARK: Private methods
    
    private func onTextChanged( _ text: String) {
        self.enteredText.text = text
    }
    
}
