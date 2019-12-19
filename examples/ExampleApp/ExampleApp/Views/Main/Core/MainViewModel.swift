//
//  MainViewModel.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeam Apps. All rights reserved.
//

import Foundation
import DT_Core_iOS
import Guise

class MainViewModel: BaseViewModel<MainInitObject> {
    
    // MARK: Properties
    
    private(set) var searchAndTableButton: ButtonFrame!
    
    private(set) var inputButton: ButtonFrame!
    
    // MARK: Dependencies
    
    private let router: RouterProtocol
    
    // MARK: Init
    
    convenience required init() {
        self.init(router: Guise.resolve()!)
    }
    
    required init(router: RouterProtocol) {
        self.router = router
        super.init()
        self.searchAndTableButton = ButtonFrame(onExecute: self.onSearchAndTableExecute)
        self.inputButton = ButtonFrame(onExecute: self.onInputExecute)
    }
    
    // MARK: Private methods
    
    private func onSearchAndTableExecute() {
        self.router.navigateTo(vmType: TableViewModel.self, initObj: TableInitObject(), navigationType: .push)
    }
    
    private func onInputExecute() {
        self.router.navigateTo(vmType: InputViewModel.self, initObj: InputInitObj(), navigationType: .push)
    }
}
