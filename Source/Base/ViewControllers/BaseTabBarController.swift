//
//  BaseTabBarController.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

class BaseTabBarController<T: BViewModel>: UITabBarController, BaseViCoProtocol {
    
    private var isViewDidLoad = false
    
    var viewModel: T?
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .fullScreen
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: BaseViCoProtocol

    func setViewModel(viewModel: Any) {
        self.viewModel = viewModel as? T
        if isViewDidLoad {
            self.viewModel?.start()
        }
    }
    
    func getViewModel() -> Any? {
        return self.viewModel
    }
    
    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        self.isViewDidLoad = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.viewAppearing()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel?.viewAppeared()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel?.viewDisappearing()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewModel?.viewDisappeared()
    }
}
