//
//  BaseViewModel.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public protocol BaseVmProtocol: class {

    func initialize(initObject: Any)

    func start()

    func viewAppearing()
    
    func viewAppeared()
    
    func viewDisappearing()
    
    func viewDisappeared()
    
}

public class BViewModel: NSObject, BaseVmProtocol {

    @Bindable(false)
    var isLoading: Bool

    required override init() {
        super.init()
    }

    public func initialize(initObject: Any) {

    }

    public func start() {
        
    }

    public func viewAppearing() {
        
    }
    
    public func viewAppeared() {
        
    }
    
    public func viewDisappearing() {
        
    }
    
    public func viewDisappeared() {
        
    }

}

public class BaseViewModel<T>: BViewModel {
    
    var initObject: T?

    override public func initialize(initObject: Any) {
        self.initObject = initObject as? T
    }

}
