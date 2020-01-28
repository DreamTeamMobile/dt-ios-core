//
//  UIView+Extensions.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

public extension UIView {

    func applySketchShadow(color: UIColor = .black, alpha: Float = 0.5, x: CGFloat = 0, y: CGFloat = 2, blur: CGFloat = 4, spread: CGFloat = 0) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let rect = bounds
            layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: spread * rect.width / 2.0, height: rect.height)).cgPath
        }
    }

    func clearShadow() {
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOpacity = 0.0
        layer.shadowPath = nil
    }

    func applyBorder(color: UIColor = .clear, width: CGFloat = 0.0) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }

    func applyGradient(colors: [UIColor] = [.white, .black], startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0), endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0)) {
        if let layer = self.layer.sublayers?.first, layer is CAGradientLayer {
            self.layer.sublayers?.removeFirst()
        }

        let gradient = CAGradientLayer()
        gradient.colors = colors.map({ $0.cgColor })

        gradient.locations = [0, 1]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.frame.size = self.frame.size
        gradient.frame.origin = .zero

        self.layer.insertSublayer(gradient, at: 0)
    }

    func roundCorners(radius: CGFloat = 0.0, mask: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = mask
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0            
        }
    }

    func startShimmering(lightColor: UIColor, darkColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.colors = [lightColor.cgColor, darkColor.cgColor, lightColor.cgColor]
        gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 3 * self.bounds.size.width, height: self.bounds.size.height)

        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.525)
        gradient.locations = [0.4, 0.5, 0.6]

        self.layer.mask = gradient

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 1.0
        animation.repeatCount = HUGE

        gradient.add(animation, forKey: "shimmer")
    }

    func stopShimmering() {
        self.layer.mask = nil
    }
    
    func findFirstResponder() -> UIView? {
        if self.isFirstResponder {
            return self
        }
        
        for view in self.subviews {
            if let firstResponder = view.findFirstResponder() {
                return firstResponder
            }
        }
        
        return nil
    }

}
