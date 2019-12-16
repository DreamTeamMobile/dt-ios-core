//
//  BindableSearchBarDelegate.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

open class BindableSearchBarDelegate: NSObject, UISearchBarDelegate {
    
    // MARK: Fields
    
    private let searchFrame: SearchFrame
    
    // MARK: Init
    
    init(searchFrame: SearchFrame) {
        self.searchFrame = searchFrame
        super.init()
    }
    
    // MARK: UISearchBarDelegate implementation
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        self.searchFrame.cancelButton.execute(nil)
        searchBar.resignFirstResponder()
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.searchFrame.clearButton.execute(nil)
        }
        self.searchFrame.searchText = searchText
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchFrame.searchButton.execute(nil)
        searchBar.resignFirstResponder()
    }
    
}
