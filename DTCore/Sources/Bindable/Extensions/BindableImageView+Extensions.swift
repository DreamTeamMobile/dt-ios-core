//
//  File.swift
//  
//
//  Created by Максим Евтух on 20.02.2020.
//

import UIKit

extension UIImageView {
    
    public func bind(_ frame: ImageFrame) {
        frame.$data.bindAndFire { [weak self] old, new in
            if let data = new {
                self?.image = UIImage(data: data)
            } else {
                self?.image = nil
            }
        }
        frame.$isHidden.bindAndFire { [weak self] old, new in
            self?.isHidden = new
        }
    }
    
}
