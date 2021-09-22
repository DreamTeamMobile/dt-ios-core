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

open class BViewModel: NSObject, BaseVmProtocol {

    @Bindable(false)
    open var isLoading: Bool

    required override public init() {
        super.init()
    }

    open func initialize(initObject: Any) {

    }

    open func start() {
        
    }

    open func viewAppearing() {
        
    }
    
    open func viewAppeared() {
        
    }
    
    open func viewDisappearing() {
        
    }
    
    open func viewDisappeared() {
        
    }

}

open class BaseViewModel<T>: BViewModel {
    
    open var initObject: T?

    override open func initialize(initObject: Any) {
        self.initObject = initObject as? T
    }

}
