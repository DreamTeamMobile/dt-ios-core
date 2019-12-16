//
//  BaseCollectionViewCell.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {

    class var identifier: String {
        get {
            return String(describing: self)
        }
    }

    class var nib: UINib {
        get {
            return UINib(nibName: self.identifier, bundle: nil)
        }
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() { }
}
