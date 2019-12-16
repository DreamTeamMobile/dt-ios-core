//
//  App.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeam Apps. All rights reserved.
//

import Foundation
import Guise
import DT_Core_iOS

class App {
    
    private static func registerDependencies() {
    }
    
    private static func registerRouting() {
        let router: RouterProtocol = Guise.resolve()!
        router.register(viewType: MainViewController.self, vmType: MainViewModel.self)
    }
    
    static func registerAppDependencies() {
        registerDependencies()
        registerRouting()
    }
    
}
