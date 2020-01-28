//
//  App.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeam Apps. All rights reserved.
//

import Foundation
import Guise
import DTCore
import DTCoreComponents

class App {
    
    private static func registerDependencies() {
        Guise.register(instance: RoutingProvider() as RoutingProviderProtocol)
        Guise.register(instance: NavigationControllerHolder() as NavigationControllerHolderProtocol)
        Guise.register(instance: Router(routingProvider: Guise.resolve()!, holder: Guise.resolve()!) as RouterProtocol)
        Guise.register(instance: TableProvider() as TableProviderProtocol)
        
        Guise.register(instance: AlertManager() as AlertProtocol)
    }
    
    private static func registerRouting() {
        let provider: RoutingProviderProtocol = Guise.resolve()!
        provider.register(viewType: MainViewController.self, vmType: MainViewModel.self)
        provider.register(viewType: InputViewController.self, vmType: InputViewModel.self)
        provider.register(viewType: TableViewController.self, vmType: TableViewModel.self)
    }
    
    static func registerAppDependencies() {
        registerDependencies()
        registerRouting()
    }
    
}
