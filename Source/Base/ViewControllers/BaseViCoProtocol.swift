//
//  BaseViCoProtocol.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

public protocol BaseViCoProtocol {

    var navigationControllerHolder: NavigationControllerHolderProtocol? { get set }
    
    func setViewModel(viewModel: Any)

    func getViewModel() -> Any?
    
}
