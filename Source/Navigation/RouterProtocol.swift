//
//  RouterProtocol.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

public protocol RouterProtocol {
    
    func navigateTo<ViewModel: BViewModel>(vmType: ViewModel.Type, initObj: Any, navigationType: NavigationType, completion: (() -> Void)?)
    
    func register<ViewController: UIViewController, ViewModel: BViewModel>(viewType: ViewController.Type, vmType: ViewModel.Type)
    
    func get<ViewModel: BViewModel>(vmType: ViewModel.Type, initObj: Any) -> UIViewController
    
    func setCurrentNavigationController(_ navigationController: UINavigationController?)
    
    func close<ViewModel: BViewModel>(vmType: ViewModel.Type, completion: (() -> Void)?)
    
    func resolveRequestedTransactions()
    
    func requestNavigation<ViewModel: BViewModel>(vmType: ViewModel.Type, initObj: Any, navigationType: NavigationType)
    
}
