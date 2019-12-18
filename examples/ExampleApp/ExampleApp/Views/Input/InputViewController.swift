//
//  InputViewController.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit
import DT_Core_iOS

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
        
        guard let viewModel = self.viewModel else {
            return
        }
        
        self.textFieldDelegate = BindableTextFieldDelegate(inputFrame: viewModel.inputFrame, textField: self.textField)
        self.textField.delegate = self.textFieldDelegate
        
        self.switchControl.isOn = viewModel.switchFrame.$isOn.wrappedValue
        viewModel.switchFrame.$isOn.bind { [weak self] oldValue, newValue in
            self?.switchControl.isOn = newValue
        }
        
        viewModel.buttonFrame.$enabled.bindAndFire { [weak self] oldValue, newValue in
            self?.button.isEnabled = newValue
        }
        self.button.addTarget(viewModel.buttonFrame, action: #selector(viewModel.buttonFrame.execute(_:)), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @IBAction func switch_onValueChanged(_ sender: Any) {
        guard let viewModel = self.viewModel else {
            return
        }
        viewModel.switchFrame.isOn = self.switchControl.isOn
    }
    
}
