//
//  RouterProtocol.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

public protocol RouterProtocol {
    
    func navigateTo<ViewModel: BViewModel>(vmType: ViewModel.Type, initObj: Any, navigationType: NavigationType, completion: (() -> Void)?)
        
    func close<ViewModel: BViewModel>(vmType: ViewModel.Type, completion: (() -> Void)?)
        
    func requestNavigation<ViewModel: BViewModel>(vmType: ViewModel.Type, initObj: Any, navigationType: NavigationType)
    
    func resolveRequestedNavigations()
    
}
