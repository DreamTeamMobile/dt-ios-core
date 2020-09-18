//
//  File.swift
//  
//
//  Created by Максим Евтух on 20.02.2020.
//

import UIKit

extension UISearchBar {
    
    public func bind(_ frame: SearchFrame) -> BindableSearchBarDelegate {
        let delegate = BindableSearchBarDelegate(searchFrame: frame)
        self.delegate = delegate
        return delegate
    }
    
}
