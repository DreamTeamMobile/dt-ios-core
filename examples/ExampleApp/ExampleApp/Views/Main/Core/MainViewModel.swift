//
//  MainViewModel.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeam Apps. All rights reserved.
//

import Foundation
import DT_Core_iOS

class MainViewModel: BaseViewModel<MainInitObject> {
    
    // MARK: Properties
    
    private(set) var searchAndTable: ButtonFrame!
    
    // MARK: Init
    
    required init() {
        self.searchAndTable = ButtonFrame()
        let t = SearchFrame()
    }
    
    // MARK: Private methods
    
    private func onSearchAndTableExecute() {
        
    }
}
