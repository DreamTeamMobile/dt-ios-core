//
//  SearchFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public class SearchFrame: NSObject {
    
    // MARK: Fields
    
    private let searchingHandler: (String) -> Void
    
    private let cancellationHandler: () -> Void
    
    private let clearingHandler: () -> Void
    
    // MARK: Properties
    
    var searchOnEveryTextChanging = false
    
    var searchText: String = "" {
        didSet {
            if searchOnEveryTextChanging {
                self.searchingHandler(self.searchText)
            }
        }
    }
    
    private(set) var searchButton: ButtonFrame!
    
    private(set) var cancelButton: ButtonFrame!
    
    private(set) var clearButton: ButtonFrame!
    
    // MARK: Init
    
    init(searchingHandler: @escaping (String) -> Void, cancellationHandler: @escaping () -> Void, clearingHandler: @escaping () -> Void) {
        self.searchingHandler = searchingHandler
        self.cancellationHandler = cancellationHandler
        self.clearingHandler = clearingHandler
        
        super.init()
                
        self.searchButton = ButtonFrame(onExecute: onSearchExecute)
        self.cancelButton = ButtonFrame(onExecute: onCancelExecute)
        self.clearButton = ButtonFrame(onExecute: onClearExecute)
    }
    
    // MARK: Private methods
    
    private func onSearchExecute() {
        self.searchingHandler(self.searchText)
    }
    
    private func onCancelExecute() {
        self.searchText = ""
        self.cancellationHandler()
    }
    
    private func onClearExecute() {
        self.searchText = ""
        self.clearingHandler()
    }
}
