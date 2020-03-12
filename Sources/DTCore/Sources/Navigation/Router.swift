//
//  Router.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

public class Router: NSObject, RouterProtocol {
    
    // MARK: Properties
    
    private var requestedTransactions = [Transaction]()
    
    // MARK: Dependencies
    
    private let routingProvider: RoutingProviderProtocol
    
    private let holder: NavigationControllerHolderProtocol
    
    // MARK: Init
    
    public init(routingProvider: RoutingProviderProtocol, holder: NavigationControllerHolderProtocol) {
        self.routingProvider = routingProvider
        self.holder = holder
    }

    // MARK: Private methods
    
    private func present(vc: UIViewController, completion: (() -> Void)? = nil) {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        let lastPresented = getLastPresentedControllerFor(rootViewController)
        lastPresented.present(vc, animated: true, completion: completion)
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
    
    private func popViewController<ViewModel: BViewModel>(naviCon: UINavigationController, vmType: ViewModel.Type, completion: (() -> Void)?) {
        for i in 0 ..< naviCon.children.count {
            let viCo = naviCon.children[i]
            if let bViCo = viCo as? BaseViCoProtocol,
                let _ = bViCo.getViewModel() as? ViewModel {
                if i == naviCon.children.count - 1 {
                    naviCon.popViewController(animated: true)
                } else {
                    viCo.removeFromParent()
                }
                completion?()
            }
        }
    }
    
    // MARK: RouterProtocol implementation
    
    public func navigateTo<ViewModel: BViewModel>(vmType: ViewModel.Type, initObj: Any, navigationType: NavigationType, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            let viewController = strongSelf.routingProvider.get(vmType: vmType, initObj: initObj)
            if var baseViCo = (viewController as? BaseViCoProtocol) {
                baseViCo.navigationControllerHolder = strongSelf.holder
            }
            
            switch navigationType {
            case .present:
                strongSelf.present(vc: viewController, completion: completion)
            case .presentInNav:
                let navViCo = UINavigationController(rootViewController: viewController)
                navViCo.modalPresentationStyle = viewController.modalPresentationStyle
                navViCo.modalTransitionStyle = viewController.modalTransitionStyle
                strongSelf.present(vc: navViCo, completion: completion)
            case .push:
                strongSelf.holder.getCurrentNavigationController()?.pushViewController(viewController, animated: true)
                completion?()
            case .pushRoot:
                if let navCon = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                    navCon.pushViewController(viewController, animated: true)
                    completion?()
                }
            case .changeRoot:
                UIApplication.shared.keyWindow?.rootViewController = viewController
                UIApplication.shared.keyWindow?.makeKeyAndVisible()
                completion?()
            case .switchTab:
                if let tabController = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController
                {
                    if let navigationController = tabController.viewControllers?.first(where: {
                        let rootViCo = ($0 as? UINavigationController)?.viewControllers.first ?? $0
                        if let baseViCo = rootViCo as? BaseViCoProtocol, let viewModel = baseViCo.getViewModel() {
                            return type(of: viewModel) == vmType
                        }
                        return false
                    }) as? UINavigationController
                    {
                        navigationController.popToRootViewController(animated: false)
                        if let viCo = navigationController.topViewController as? BaseViewController<ViewModel> {
                            viCo.viewModel?.initialize(initObject: initObj)
                        }
                        tabController.selectedViewController = navigationController
                        completion?()
                    }
                }
            }
        }
    }
    
    public func close<ViewModel: BViewModel>(vmType: ViewModel.Type, completion: (() -> Void)?) {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        if let presented = rootViewController.presentedViewController {
            let lastPresented = getLastPresentedControllerFor(presented, vmType)
            if let naviCon = lastPresented as? UINavigationController {
                popViewController(naviCon: naviCon, vmType: vmType, completion: completion)
            } else {
                lastPresented.dismiss(animated: true) {
                    completion?()
                }
            }
        } else if let naviCon = self.holder.getCurrentNavigationController() {
            popViewController(naviCon: naviCon, vmType: vmType, completion: completion)
        }
    }
    
    public func requestNavigation<ViewModel: BViewModel>(vmType: ViewModel.Type, initObj: Any, navigationType: NavigationType) {
        self.requestedTransactions.append(Transaction(vmType: vmType, initObj: initObj, navigationType: navigationType))
    }
    
    public func resolveRequestedNavigations() {
        if let transaction = self.requestedTransactions.first {
            self.requestedTransactions.removeFirst()
            DispatchQueue.main.async {
                self.navigateTo(vmType: transaction.vmType, initObj: transaction.initObj, navigationType: transaction.navigationType) {
                    self.resolveRequestedNavigations()
                }
            }
        }
    }
    
}
