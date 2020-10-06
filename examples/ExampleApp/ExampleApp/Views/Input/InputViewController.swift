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

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewModel = self.viewModel else { return }

        self.textFieldDelegate = self.textField.bind(viewModel.inputFrame)

        viewModel.switchFrame.$isOn.bindAndFire { [weak self] oldValue, newValue in
            self?.switchControl.isOn = newValue
        }

        self.button.bind(viewModel.buttonFrame)
    }

    // MARK: Actions

    @IBAction func switch_onValueChanged(_ sender: Any) {
        guard let viewModel = self.viewModel else { return }
        viewModel.switchFrame.isOn = self.switchControl.isOn
    }

}
