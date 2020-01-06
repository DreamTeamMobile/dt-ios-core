//
//  BaseViewController.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

open class BaseViewController<T: BViewModel>: BViewController {

    open var viewModel: T?

    // MARK: Methods
        
    open func bindLoadingState() {
        self.viewModel?.$isLoading.bindAndFire { [weak self] old, new in
            if new {
                self?.showLoader()
            } else {
                self?.hideLoader()
            }
        }
    }

    // MARK: BaseViCoProtocol

    override open func setViewModel(viewModel: Any) {
        self.viewModel = viewModel as? T
    }
    
    override open func getViewModel() -> Any? {
        return self.viewModel
    }

    // MARK: Overrides

    override open func viewDidLoad() {
        super.viewDidLoad()
        bindLoadingState()
        self.viewModel?.start()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.viewAppearing()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel?.viewAppeared()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel?.viewDisappearing()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewModel?.viewDisappeared()
    }

}
