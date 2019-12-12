//
//  BindableTableViewSource.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

public class BindableTableViewSource<T> : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Fields
    
    let tableView: UITableView
    
    let tableFrame: CollectionFrame<T>
    
    let cellIdentifier: String
    
    // MARK: Init
    
    init(tableView: UITableView, tableFrame: CollectionFrame<T>, cellIdentifier: String) {
        self.tableView = tableView
        self.tableFrame = tableFrame
        self.cellIdentifier = cellIdentifier
        super.init()
        setupBindings()
    }
    
    // MARK: Private methods
    
    private func setupBindings() {
        self.tableFrame.$itemsSource.bindAndFire(onItemsSourceChanged)
    }
        
    // MARK: Methods
    
    func getItemAt(_ indexPath: IndexPath) -> T {
        return self.tableFrame.itemsSource[indexPath.row]
    }
    
    func onItemsSourceChanged(_ oldItems: [T], _ newItems: [T]) {
        self.tableView.reloadData()
    }
    
    func getCellIdentifier(_ indexPath: IndexPath) -> String {
        return self.cellIdentifier
    }
    
    // MARK: UITableViewDataSource implementation
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableFrame.itemsSource.count
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: getCellIdentifier(indexPath))!
        if let bindable = cell as? BindableTableViewCell<T> {
            bindable.dataContext = getItemAt(indexPath)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return nil
    }
        
    // MARK: UITableViewDelegate implementation
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = getItemAt(indexPath)
        self.tableFrame.onItemSelected(item: item)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }

    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

    }
    
}
