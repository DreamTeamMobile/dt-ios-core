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
    var isLoading: Bool

    required override public init() {
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

open class BaseViewModel<T>: BViewModel {
    
    var initObject: T?

    override public func initialize(initObject: Any) {
        self.initObject = initObject as? T
    }

}
