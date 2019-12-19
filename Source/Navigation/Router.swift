//
//  Router.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

public class Router: NSObject, RouterProtocol {
    
    private var currentNavigationController: UINavigationController?
    private var map = [String: UIViewController.Type]()

    fileprivate func initViewController<ViewController: UIViewController, ViewModel: BViewModel>(viewType: ViewController.Type, vmType: ViewModel.Type, initObj: Any) -> UIViewController {
        let viewController = viewType.init(nibName: viewType.nibName, bundle: nil)
        let viewModel = vmType.init()
                
        if var baseViCo = viewController as? BaseViCoProtocol {
            baseViCo.setViewModel(viewModel: viewModel)
            baseViCo.router = self
        }
        
        viewModel.initialize(initObject: initObj)        

        return viewController
    }

    // MARK: Private methods
    
    private func present(vc: UIViewController) {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        let lastPresented = getLastPresentedControllerFor(rootViewController)
        lastPresented.present(vc, animated: true, completion: nil)
    }
    
    private func getLastPresentedControllerFor(_ viewController: UIViewController) -> UIViewController {
        if let presented = viewController.presentedViewController {
            return getLastPresentedControllerFor(presented)
        }
        
        return viewController
    }
    
    private func getLastPresentedControllerFor<ViewModel: BViewModel>(_ viewController: UIViewController, _ vmType: ViewModel.Type) -> UIViewController {
        if let presented = viewController.presentedViewController {
            if let bViCo = presented as? BaseViCoProtocol, let _ = bViCo.getViewModel() as? ViewModel {
                return presented
            }
            return getLastPresentedControllerFor(presented)
        }
        
        return viewController
    }
    
    // MARK: Methods
    
    public func navigateTo<ViewModel: BViewModel>(vmType: ViewModel.Type, initObj: Any, navigationType: NavigationType) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            if let viewType = strongSelf.map[vmType.description()] {
                switch navigationType {
                case .present:
                    let viewController = strongSelf.initViewController(viewType: viewType, vmType: vmType, initObj: initObj)
                    strongSelf.present(vc: viewController)
                case .presentInNav:
                    let viewController = strongSelf.initViewController(viewType: viewType, vmType: vmType, initObj: initObj)
                    let navViCo = UINavigationController(rootViewController: viewController)
                    navViCo.modalPresentationStyle = viewController.modalPresentationStyle
                    navViCo.modalTransitionStyle = viewController.modalTransitionStyle
                    strongSelf.present(vc: navViCo)
                case .push:
                    let viewController = strongSelf.initViewController(viewType: viewType, vmType: vmType, initObj: initObj)
                    strongSelf.currentNavigationController?.pushViewController(viewController, animated: true)
                case .pushRoot:
                    if let navCon = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                        let viewController = strongSelf.initViewController(viewType: viewType, vmType: vmType, initObj: initObj)
                        navCon.pushViewController(viewController, animated: true)
                    }
                case .switchTab:
                    if let tabController = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController {
                        if let navigationController = tabController.viewControllers?.first(where: { ($0 as! UINavigationController).topViewController as? BaseViewController<ViewModel> != nil }) as? UINavigationController {
                            if let viCo = navigationController.topViewController as? BaseViewController<ViewModel> {
                                viCo.viewModel?.initialize(initObject: initObj)
                            }
                            tabController.selectedViewController = navigationController
                        }
                    }
                case .changeRoot:
                    let viewController = strongSelf.initViewController(viewType: viewType, vmType: vmType, initObj: initObj)
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    UIApplication.shared.keyWindow?.makeKeyAndVisible()
                }
            }
        }
    }

    public func register<ViewController: UIViewController, ViewModel: BViewModel>(viewType: ViewController.Type, vmType: ViewModel.Type) {
        self.map[vmType.description()] = viewType
    }

    public func get<ViewModel: BViewModel>(vmType: ViewModel.Type, initObj: Any) -> UIViewController {
        let viewType = self.map[vmType.description()]!
        return initViewController(viewType: viewType, vmType: vmType, initObj: initObj)
    }

    public func close<ViewModel: BViewModel>(vmType: ViewModel.Type, completion: (() -> Void)?) {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        if let presented = rootViewController.presentedViewController {
            let lastPresented = getLastPresentedControllerFor(presented, vmType)
            lastPresented.dismiss(animated: true) {
                completion?()
            }
        } else {
            self.currentNavigationController?.popViewController(animated: true)
        }
    }

    public func setCurrentNavigationController(_ navigationController: UINavigationController?) {
        if let nc = navigationController {
            self.currentNavigationController = nc
        }
    }
}
