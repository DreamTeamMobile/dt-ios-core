//
//  BaseView.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {}
}

fileprivate extension BaseView {

    func commonInit() {
        guard subviews.count == 0, let contentView = loadFromNib() else { return }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        contentView.clipsToBounds = true
        addSubview(contentView)
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }

    func loadFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last ?? ""
        if Bundle.main.path(forResource: nibName, ofType: "nib") != nil {
            let nib = UINib(nibName: nibName, bundle: bundle)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        } else {
            return nil
        }
    }

}
