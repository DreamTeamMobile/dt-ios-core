//
//  UICollectionView+Extensions.swift
//  DTCore
//
//  Created by Максим Евтух on 01.07.2021.
//  Copyright © 2021 DreamTeam. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register(identifiers: [String]) {
        for identifier in identifiers {
            register(
                UINib(
                    nibName: identifier,
                    bundle: nil
                ),
                forCellWithReuseIdentifier: identifier
            )
        }
    }
    
}
