//
//  BindableSectionedTableViewSource.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

open class BindableSectionedTableViewSource<T> : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Fields
    
    public let tableView: UITableView
    
    public let tableFrame: SectionedCollectionFrame<T>
    
    public let cellIdentifier: String
    
    // MARK: Init
        
    convenience init(tableView: UITableView, tableFrame: SectionedCollectionFrame<T>) {
        self.init(tableView: tableView, tableFrame: tableFrame, cellIdentifier: "")
    }
    
    init(tableView: UITableView, tableFrame: SectionedCollectionFrame<T>, cellIdentifier: String) {
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
    
    open func getCellIdentifier(_ indexPath: IndexPath) -> String {
        return self.cellIdentifier
    }

    open func getItemAt(_ indexPath: IndexPath) -> T {
        return getSectionAt(indexPath.section).items[indexPath.row]
    }
    
    open func getSectionAt(_ section: Int) -> Section<T> {
        return self.tableFrame.itemsSource[section]
    }
    
    open func onItemsSourceChanged(_ oldItems: [Section<T>], _ newItems: [Section<T>]) {
        self.tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource implementation
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getSectionAt(section).items.count
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableFrame.itemsSource.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: getCellIdentifier(indexPath), for: indexPath)
        if let bindable = cell as? BindableTableViewCell<T> {
            bindable.dataContext = getItemAt(indexPath)
        }
        return cell
    }
    
    open func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return nil
    }
    
    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
        
    // MARK: UITableViewDelegate implementation
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section = getSectionAt(indexPath.section)
        let item = getItemAt(indexPath)
        self.tableFrame.onItemSelected(item: item, sectionType: section.type)
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    open func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }

    open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

    }
    
}
