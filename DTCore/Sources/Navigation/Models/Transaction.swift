//
//  Transaction.swift
//  fitnesslab
//
//  Created by Максим Евтух on 28.12.2019.
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

struct Transaction {
    let vmType: BViewModel.Type
    let initObj: Any
    let navigationType: NavigationType
}
