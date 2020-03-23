//
//  BindableTableViewSource.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

open class BindableTableViewSource<T> : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Fields
    
    public let tableView: UITableView
    
    public let tableFrame: CollectionFrame<T>
    
    public let cellIdentifier: String
    
    // MARK: Init
        
    convenience public init(tableView: UITableView, tableFrame: CollectionFrame<T>) {
        self.init(tableView: tableView, tableFrame: tableFrame, cellIdentifier: "")
    }
    
    public init(tableView: UITableView, tableFrame: CollectionFrame<T>, cellIdentifier: String) {
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
    
    open func getItemAt(_ indexPath: IndexPath) -> T {
        return self.tableFrame.itemsSource[indexPath.row]
    }
    
    open func onItemsSourceChanged(_ oldItems: [T], _ newItems: [T]) {
        self.tableView.reloadData()
    }
    
    open func getCellIdentifier(_ indexPath: IndexPath) -> String {
        return self.cellIdentifier
    }
    
    // MARK: UITableViewDataSource implementation
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableFrame.itemsSource.count
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: getCellIdentifier(indexPath))!
        if let bindable = cell as? BindableTableViewCell<T> {
            bindable.dataContext = getItemAt(indexPath)
        }
        return cell
    }
    
    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    open func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    open func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if let actions = self.tableFrame.actions {
            return actions.map { act in
                UITableViewRowAction(
                    style: act.type == .normal ? .normal : .destructive,
                    title: act.title,
                    handler: { [weak self] action, indexPath in
                        guard let strongSelf = self else { return }
                        let item = strongSelf.getItemAt(indexPath)
                        act.action(item)
                })
            }
        }
        return [UITableViewRowAction]()
    }
    
    open func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    open func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
        
    // MARK: UITableViewDelegate implementation
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = getItemAt(indexPath)
        self.tableFrame.onItemSelected(item: item)
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }

    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    open func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }

    open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

    }
    
}
