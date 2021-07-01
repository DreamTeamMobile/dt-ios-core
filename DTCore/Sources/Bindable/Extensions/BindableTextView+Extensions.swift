//
//  BindableTextView+Extensions.swift
//  DTCore
//
//  Created by Максим Евтух on 01.07.2021.
//  Copyright © 2021 DreamTeam. All rights reserved.
//

import UIKit

extension UITextView {
    
    public func bind(_ frame: InputFrame) -> BindableTextViewDelegate {
        let delegate = BindableTextViewDelegate(inputFrame: frame, textView: self)
        self.delegate = delegate
        return delegate
    }
    
}
