//
//  BindableSlider+Extensions.swift
//  DTCore
//
//  Created by Максим Евтух on 09.07.2021.
//  Copyright © 2021 DreamTeam. All rights reserved.
//

import UIKit

extension UISlider {
    
    public func bind<T: Numeric>(_ frame: ProgressFrame<T>) {
        frame.$value.bindAndFire { [weak self] oldValue, newValue in
            guard let self = self else { return }
            self.value = self.convertNumericToFloat(newValue)
        }
        frame.$minimum.bindAndFire { [weak self] oldValue, newValue in
            guard let self = self else { return }
            self.minimumValue = self.convertNumericToFloat(newValue)
        }
        frame.$maximum.bindAndFire { [weak self] oldValue, newValue in
            guard let self = self else { return }
            self.maximumValue = self.convertNumericToFloat(newValue)
        }
        
        frame.$isHidden.bindAndFire { [weak self] oldValue, newValue in
            self?.isHidden = newValue
        }
        frame.$enabled.bindAndFire { [weak self] oldValue, newValue in
            self?.isEnabled = newValue
        }
        
        self.removeTarget(nil, action: nil, for: .valueChanged)
        self.addTarget(frame, action: #selector(frame.onValueChanged), for: .valueChanged)
    }
    
    private func convertNumericToFloat<T: Numeric>(_ value: T) -> Float {
        var convertedValue: Float = 0
        
        let type = type(of: value)
        if type == Float.self, let v = value as? Float {
            convertedValue = v
        } else if type == Int.self, let v = value as? Int {
            convertedValue = Float(v)
        } else {
            assertionFailure("Type \(type) is not supported by UISlider binding")
        }
        
        return convertedValue
    }
    
}
