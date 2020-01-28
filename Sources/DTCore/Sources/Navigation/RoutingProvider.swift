//
//  RoutingProvider.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

public class RoutingProvider: NSObject, RoutingProviderProtocol {
    
    // MARK: Properties
    
    private var map = [String: UIViewController.Type]()
    
    // MARK: Private methods
    
    private func initViewController<ViewController: UIViewController, ViewModel: BViewModel>(viewType: ViewController.Type, vmType: ViewModel.Type, initObj: Any) -> UIViewController {
        let viewController = viewType.init(nibName: viewType.nibName, bundle: nil)
        let viewModel = vmType.init()
        viewModel.initialize(initObject: initObj)
        
        (viewController as? BaseViCoProtocol)?.setViewModel(viewModel: viewModel)

        return viewController
    }
    
    // MARK: RoutingProviderProtocol implementation
    
    public func register<ViewController: UIViewController, ViewModel: BViewModel>(viewType: ViewController.Type, vmType: ViewModel.Type) {
        self.map[vmType.description()] = viewType
    }

    public func get<ViewModel: BViewModel>(vmType: ViewModel.Type, initObj: Any) -> UIViewController {
        let viewType = self.map[vmType.description()]!
        return initViewController(viewType: viewType, vmType: vmType, initObj: initObj)
    }
    
}
