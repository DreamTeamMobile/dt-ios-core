//
//  MainViewController.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeam Apps. All rights reserved.
//

import DTCore
import UIKit

class MainViewController: BaseViewController<MainViewModel> {

    // MARK: Outlets

    @IBOutlet weak var searchAndTableBtn: UIButton!

    @IBOutlet weak var inputBtn: UIButton!

    @IBOutlet weak var multipleBtn: UIButton!
    
    // MARK: Overrides

    override func bindControls(_ viewModel: MainViewModel) {
        self.searchAndTableBtn.bind(viewModel.searchAndTableButton)
        self.inputBtn.bind(viewModel.inputButton)
        self.multipleBtn.bind(viewModel.multipleButton)
    }

}
