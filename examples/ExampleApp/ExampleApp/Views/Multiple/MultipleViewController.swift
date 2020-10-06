//
//  MultipleViewController.swift
//  ExampleApp
//
//  Created by Максим Евтух on 06.10.2020.
//  Copyright © 2020 DreamTeam Apps. All rights reserved.
//

import DTCore
import DTCoreComponents
import UIKit

class MultipleViewController: BaseViewController<MultipleViewModel> {

    // MARK: Fields

    private var delegate: TmpBindableTextFieldDelegate?

    private var token1: UUID?
    private var token2: UUID?

    // MARK: Outlets

    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var label1: UILabel!

    @IBOutlet weak var label2: UILabel!

    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewModel = self.viewModel else { return }
        
        self.delegate = TmpBindableTextFieldDelegate(inputFrame: viewModel.inputFrame, textField: self.textField)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let viewModel = self.viewModel else { return }
                
        self.token1 = viewModel.enteredText.$text.subscribe { [weak self] (old, new) in
            self?.label1.text = new
        }
        self.token2 = viewModel.enteredText.$text.subscribe { [weak self] (old, new) in
            self?.label2.text = new
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        guard let viewModel = self.viewModel else { return }
                
        if let t = self.token1 {
            viewModel.enteredText.$text.unsubscribe(t)
        }
        if let t = self.token2 {
            viewModel.enteredText.$text.unsubscribe(t)
        }
    }

}

open class TmpBindableTextFieldDelegate : NSObject, UITextFieldDelegate {
    
    // MARK: Fields
    
    public weak var inputFrame: InputFrame?
    
    public weak var textField: UITextField?
    
    // MARK: Properties
    
    public var onReturnExecute: (() -> Void)?
    
    // MARK: Init
    
    public init(inputFrame: InputFrame, textField: UITextField) {
        self.inputFrame = inputFrame
        self.textField = textField
        
        super.init()
        
        setupBindings(inputFrame)
    }
    
    // MARK: Private methods
    
    private func setupBindings(_ inputFrame: InputFrame) {
        self.textField?.text = inputFrame.text
        self.textField?.addTarget(self, action: #selector(onTextFieldValueChanged), for: .editingChanged)
        self.textField?.addTarget(self, action: #selector(onTextFieldValueChanged), for: .editingDidEnd)
        
        inputFrame.$text.bindAndFire(self.onTextChanged)
        inputFrame.$isHidden.bindAndFire(self.onHiddenChanged)
    }
    
    @objc private func onTextFieldValueChanged(_ sender: UITextField) {
        self.inputFrame?.text = sender.text ?? ""
    }
    
    private func onTextChanged(_ oldValue: String, _ newValue: String) {
        if newValue != self.textField?.text {
            self.textField?.text = newValue
        }
    }
    
    private func onHiddenChanged(_ oldValue: Bool, _ newValue: Bool) {
        self.textField?.isHidden = newValue
    }
    
    // MARK: UITextFieldDelegate implementation
    
    /// return NO to disallow editing.
    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    /// became first responder
    open func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }

    /// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    open func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }

    /// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    open func textFieldDidEndEditing(_ textField: UITextField) {
        
    }

    /// if implemented, called in place of textFieldDidEndEditing:
    @available(iOS 10.0, *)
    open func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
    }
    
    /// return NO to not change text
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString text: String) -> Bool {
        return self.inputFrame?.shouldChangeCharactersIn(range: range, replacementString: text) ?? true
    }
    
    @available(iOS 13.0, *)
    open func textFieldDidChangeSelection(_ textField: UITextField) {
        
    }
    
    /// called when clear button pressed. return NO to ignore (no notifications)
    open func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }

    /// called when 'return' key pressed. return NO to ignore.
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        self.onReturnExecute?()
        return true
    }
    
}

