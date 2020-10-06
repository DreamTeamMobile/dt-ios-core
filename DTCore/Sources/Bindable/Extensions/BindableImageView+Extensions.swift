//
//  File.swift
//  
//
//  Created by Максим Евтух on 20.02.2020.
//

import UIKit

extension UIImageView {
    
    public func bind(_ frame: ImageFrame) {
        frame.$data.bindAndFire { old, new in
            if let data = new {
                self.image = UIImage(data: data)
            } else {
                self.image = nil
            }
        }
        frame.$isHidden.bindAndFire { old, new in
            self.isHidden = new
        }
    }
    
}
