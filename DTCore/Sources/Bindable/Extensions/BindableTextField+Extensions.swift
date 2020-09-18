//
//  File.swift
//  
//
//  Created by Максим Евтух on 20.02.2020.
//

import UIKit

extension UITextField {
    
    public func bind(_ frame: InputFrame) -> BindableTextFieldDelegate {
        let delegate = BindableTextFieldDelegate(inputFrame: frame, textField: self)
        self.delegate = delegate
        return delegate
    }
    
}
