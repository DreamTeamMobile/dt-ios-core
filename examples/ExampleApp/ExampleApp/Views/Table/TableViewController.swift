//
//  TableViewController.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit
import DT_Core_iOS

class TableViewController: BaseViewController<TableViewModel> {
    
    // MARK: Fields
    
    private var searchBarDelegate: BindableSearchBarDelegate?
    
    private var tableViewSource: TableViewSource?
    
    // MARK: Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = self.viewModel else { return }
        
        self.searchBarDelegate = BindableSearchBarDelegate(searchFrame: viewModel.searchFrame)
        self.searchBar.delegate = self.searchBarDelegate
        
        self.tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.identifier)
        self.tableViewSource = TableViewSource(tableView: self.tableView, tableFrame: viewModel.collectionFrame, cellIdentifier: TableViewCell.identifier)
        self.tableView.dataSource = self.tableViewSource
        self.tableView.delegate = self.tableViewSource
        self.tableView.reloadData()
    }
    
}