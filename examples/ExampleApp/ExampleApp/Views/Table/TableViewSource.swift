//
//  TableViewSource.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit
import DT_Core_iOS

class TableViewSource: BindableTableViewSource<TableItemVm> {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}
