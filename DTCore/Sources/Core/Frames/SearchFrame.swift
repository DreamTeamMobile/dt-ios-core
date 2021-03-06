//
//  SearchFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public class SearchFrame: Frame {
    
    // MARK: Fields
    
    private let searchingHandler: ((String) -> Void)?
    
    private let cancellationHandler: (() -> Void)?
    
    private let clearingHandler: (() -> Void)?
    
    // MARK: Properties
    
    public var searchOnEveryTextChanging = false
    
    public var searchText: String = "" {
        didSet {
            if searchOnEveryTextChanging {
                self.searchingHandler?(self.searchText)
            }
        }
    }
    
    private(set) var searchButton: ButtonFrame!
    
    private(set) var cancelButton: ButtonFrame!
    
    private(set) var clearButton: ButtonFrame!
    
    // MARK: Init
    
    public init(searchingHandler: ((String) -> Void)?, cancellationHandler: (() -> Void)?, clearingHandler: (() -> Void)?) {
        self.searchingHandler = searchingHandler
        self.cancellationHandler = cancellationHandler
        self.clearingHandler = clearingHandler
        
        super.init()
                
        self.searchButton = ButtonFrame(onExecute: { [weak self] in self?.onSearchExecute() })
        self.cancelButton = ButtonFrame(onExecute: { [weak self] in self?.onCancelExecute() })
        self.clearButton = ButtonFrame(onExecute: { [weak self] in self?.onClearExecute() })
    }
    
    // MARK: Private methods
    
    private func onSearchExecute() {
        self.searchingHandler?(self.searchText)
    }
    
    private func onCancelExecute() {
        self.searchText = ""
        self.cancellationHandler?()
    }
    
    private func onClearExecute() {
        self.searchText = ""
        self.clearingHandler?()
    }
}
