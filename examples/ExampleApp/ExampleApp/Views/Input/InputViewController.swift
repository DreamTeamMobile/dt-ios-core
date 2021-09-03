//
//  InputViewController.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import DTCore
import UIKit

class InputViewController: BaseViewController<InputViewModel> {

    // MARK: Fields

    private var textFieldDelegate: BindableTextFieldDelegate?

    // MARK: Outlets

    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var switchControl: UISwitch!

    @IBOutlet weak var button: UIButton!

    // MARK: Overrides
    
    override func bindControls(_ viewModel: InputViewModel) {
        self.textFieldDelegate = self.textField.bind(viewModel.inputFrame)

        self.switchControl.bind(viewModel.switchFrame)

        self.button.bind(viewModel.buttonFrame)
    }
}
