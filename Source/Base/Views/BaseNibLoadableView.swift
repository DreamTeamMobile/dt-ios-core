//
//  BaseNibLoadableView.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

open class BaseNibLoadableView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    open func loadFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        if Bundle.main.path(forResource: nibName, ofType: "nib") != nil {
            let nib = UINib(nibName: nibName, bundle: bundle)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        } else {
            return nil
        }
    }
    
}

private extension BaseNibLoadableView {
    
    func loadNib() {
        if self.subviews.count == 0 {
            if let contentView = loadFromNib() {
                addSubview(contentView)
                contentView.frame = self.bounds
                contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            }
        }
    }
    
}
