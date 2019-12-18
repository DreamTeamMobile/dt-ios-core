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
        Guise.register(instance: Router() as RouterProtocol)
        Guise.register(instance: TableProvider() as TableProviderProtocol)
    }
    
    private static func registerRouting() {
        let router: RouterProtocol = Guise.resolve()!
        router.register(viewType: MainViewController.self, vmType: MainViewModel.self)
        router.register(viewType: InputViewController.self, vmType: InputViewModel.self)
        router.register(viewType: TableViewController.self, vmType: TableViewModel.self)
    }
    
    static func registerAppDependencies() {
        registerDependencies()
        registerRouting()
    }
    
}
