//
//  BaseViewController.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

open class BaseViewController<T: BViewModel>: BViewController {

    open var viewModel: T?

    // MARK: Methods
        
    open func bindLoadingState(_ viewModel: T) {
        viewModel.$isLoading.bindAndFire { [weak self] _, isLoading in
            guard let self = self else { return }
            
            isLoading
                ? self.showLoader()
                : self.hideLoader()
        }
    }
    
    open func setupControls() {
        
    }
    
    open func bindControls(_ viewModel: T) {
        
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
                
        guard let viewModel = self.viewModel else { return }
        
        bindLoadingState(viewModel)
        
        viewModel.start()
        
        setupControls()
        bindControls(viewModel)
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
