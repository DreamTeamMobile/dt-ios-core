//
//  InputViewModel.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import DTCore
import DTCoreComponents
import Foundation
import Guise

class InputViewModel: BaseViewModel<InputInitObj> {

    // MARK: Properties

    private(set) var inputFrame: InputFrame!

    private(set) var switchFrame: SwitchFrame!

    private(set) var buttonFrame: ButtonFrame!

    // MARK: Dependencies

    private let alertManager: AlertProtocol

    // MARK: Init

    required convenience init() {
        self.init(alertManager: Guise.resolve()!)
    }

    init(
        alertManager: AlertProtocol
    ) {
        self.alertManager = alertManager
        super.init()
        self.inputFrame = InputFrame(onTextChanged: { [weak self] txt in self?.onTextChanged(txt) }, textValidator: nil)
        self.switchFrame = SwitchFrame(value: false, onValueChanged: { [weak self] value in self?.onValueChanged(value) })
        self.buttonFrame = ButtonFrame(title: "Button", onExecute: { [weak self] in self?.onButtonExecute() })
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
        self.alertManager.showAlert(message: "Success", predicate: nil)
    }

    // MARK: Overrides

    override func start() {
        super.start()
        updateButton()
    }
}
