//
//  BindableSearchBarDelegate.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

open class BindableSearchBarDelegate: NSObject, UISearchBarDelegate {
    
    // MARK: Fields
    
    public weak var searchFrame: SearchFrame?
    
    // MARK: Init
    
    public init(searchFrame: SearchFrame) {
        self.searchFrame = searchFrame
        
        super.init()
    }
    
    // MARK: UISearchBarDelegate implementation
    
    open func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    open func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    open func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        self.searchFrame?.cancelButton.execute(nil)
        searchBar.resignFirstResponder()
    }
    
    open func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.searchFrame?.clearButton.execute(nil)
        }
        self.searchFrame?.searchText = searchText
    }
    
    open func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchFrame?.searchButton.execute(nil)
        searchBar.resignFirstResponder()
    }
    
}
