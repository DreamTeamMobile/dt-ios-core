//
//  TableViewController.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import DTCore
import UIKit

class TableViewController: BaseViewController<TableViewModel> {

    // MARK: Fields

    private var searchBarDelegate: BindableSearchBarDelegate?

    private var tableViewSource: TableViewSource?

    // MARK: Outlets

    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var tableView: UITableView!

    // MARK: Overrides

    override func bindControls(_ viewModel: TableViewModel) {
        self.searchBarDelegate = self.searchBar.bind(viewModel.searchFrame)

        self.tableViewSource = TableViewSource(
            tableView: self.tableView,
            tableFrame: viewModel.collectionFrame,
            cellIdentifier: TableViewCell.identifier
        )
    }
    
}
