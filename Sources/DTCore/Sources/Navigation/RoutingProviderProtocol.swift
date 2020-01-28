//
//  RoutingProviderProtocol.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

public protocol RoutingProviderProtocol {
    
    func register<ViewController: UIViewController, ViewModel: BViewModel>(viewType: ViewController.Type, vmType: ViewModel.Type)
    
    func get<ViewModel: BViewModel>(vmType: ViewModel.Type, initObj: Any) -> UIViewController
    
}
