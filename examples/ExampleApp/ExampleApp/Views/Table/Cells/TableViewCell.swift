//
//  TableViewCell.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit
import DT_Core_iOS

class TableViewCell: BindableTableViewCell<TableItemVm> {
    
    override var dataContext: TableItemVm? {
        didSet {
            guard let data = self.dataContext else { return }
            self.textLabel?.text = data.title
        }
    }
    
}
