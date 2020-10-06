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

    private var delegate: BindableTextFieldDelegate?

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
        self.delegate = self.textField.bind(viewModel.inputFrame)
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
