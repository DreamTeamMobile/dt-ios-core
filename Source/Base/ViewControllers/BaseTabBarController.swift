//
//  BaseTabBarController.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

open class BaseTabBarController<T: BViewModel>: UITabBarController, BaseViCoProtocol {
    
    private var isViewDidLoad = false
    
    var viewModel: T?
    
    public var router: RouterProtocol?
    
    required override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .fullScreen
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: BaseViCoProtocol

    open func setViewModel(viewModel: Any) {
        self.viewModel = viewModel as? T
        if isViewDidLoad {
            self.viewModel?.start()
        }
    }
    
    open func getViewModel() -> Any? {
        return self.viewModel
    }
    
    // MARK: Overrides

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.isViewDidLoad = true
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
