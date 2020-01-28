//
//  MainViewController.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeam Apps. All rights reserved.
//

import UIKit
import DTCoreCommons

class MainViewController: BaseViewController<MainViewModel> {
    
    // MARK: Outlets
    
    @IBOutlet weak var searchAndTableBtn: UIButton!
    
    @IBOutlet weak var inputBtn: UIButton!
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = self.viewModel else {
            return
        }
        
        self.searchAndTableBtn.addTarget(viewModel.searchAndTableButton, action: #selector(viewModel.searchAndTableButton.execute(_:)), for: .touchUpInside)
        self.inputBtn.addTarget(viewModel.inputButton, action: #selector(viewModel.inputButton.execute(_:)), for: .touchUpInside)
    }
    
}
