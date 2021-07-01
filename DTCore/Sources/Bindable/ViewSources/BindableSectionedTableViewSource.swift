//
//  BindableSectionedTableViewSource.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

open class BindableSectionedTableViewSource<ItemType, SectionType>: NSObject, UITableViewDataSource,
    UITableViewDelegate
{
    // MARK: Fields

    public weak var tableView: UITableView?

    public weak var tableFrame: SectionedCollectionFrame<ItemType, SectionType>?

    public let cellIdentifiers: [String]

    // MARK: Init

    convenience public init(
        tableView: UITableView,
        tableFrame: SectionedCollectionFrame<ItemType, SectionType>
    ) {
        self.init(tableView: tableView, tableFrame: tableFrame, cellIdentifier: "")
    }

    convenience public init(tableView: UITableView, tableFrame: SectionedCollectionFrame<ItemType, SectionType>, cellIdentifier: String) {
        self.init(tableView: tableView, tableFrame: tableFrame, cellIdentifiers: [cellIdentifier])
    }
    
    public init(tableView: UITableView, tableFrame: SectionedCollectionFrame<ItemType, SectionType>, cellIdentifiers: [String]) {
        self.tableView = tableView
        self.tableFrame = tableFrame
        self.cellIdentifiers = cellIdentifiers
        
        super.init()
        
        registerCells()
        setupCollectionView()
        setupBindings()
    }

    // MARK: Private methods

    private func registerCells() {
        self.tableView?.register(identifiers: self.cellIdentifiers)
    }
    
    private func setupCollectionView() {
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
    }
    
    private func setupBindings() {
        self.tableFrame?.$itemsSource.bindAndFire(onItemsSourceChanged)
    }

    // MARK: Methods

    open func getCellIdentifier(_ indexPath: IndexPath) -> String {
        return self.cellIdentifiers.first!
    }

    open func getItemAt(_ indexPath: IndexPath) -> ItemType? {
        return getSectionAt(indexPath.section)?.itemsSource[indexPath.row]
    }

    open func getSectionAt(_ section: Int) -> Section<ItemType, SectionType>? {
        return self.tableFrame?.itemsSource[section]
    }

    open func onItemsSourceChanged(
        _ oldItems: [Section<ItemType, SectionType>],
        _ newItems: [Section<ItemType, SectionType>]
    ) {
        self.tableView?.reloadData()
    }

    // MARK: UITableViewDataSource implementation

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getSectionAt(section)?.itemsSource.count ?? 0
    }

    open func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableFrame?.itemsSource.count ?? 0
    }

    open func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: getCellIdentifier(indexPath),
            for: indexPath
        )
        if let bindable = cell as? BindableTableViewCell<ItemType> {
            bindable.dataContext = getItemAt(indexPath)
        }
        return cell
    }

    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    open func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath
    ) -> UITableViewCell.EditingStyle {
        return .none
    }

    open func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {

    }

    open func tableView(
        _ tableView: UITableView,
        editActionsForRowAt indexPath: IndexPath
    ) -> [UITableViewRowAction]? {
        if let actions = self.tableFrame?.actions {
            return actions.map { act in
                let rowAction = UITableViewRowAction(
                    style: act.type == .normal ? .normal : .destructive,
                    title: act.title,
                    handler: { [weak self] action, indexPath in
                        guard let strongSelf = self else { return }
                        guard let section = strongSelf.getSectionAt(indexPath.section), let item = strongSelf.getItemAt(indexPath) else { return }
                        act.action(
                            Section<ItemType, SectionType>(type: section.type, items: [item])
                        )
                    }
                )
                
                rowAction.backgroundColor = act.backgroundColor
                
                return rowAction
            }
        }
        return []
    }

    @available(iOS 11.0, *)
    open func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {

        if let actions = self.tableFrame?.actions {
            let actions: [UIContextualAction] = actions.map { act in
                let contextAct = UIContextualAction(
                    style: act.type == .normal ? .normal : .destructive,
                    title: act.title
                ) { [weak self] action, sourceView, completion in
                    guard let strongSelf = self else { return }
                    guard let section = strongSelf.getSectionAt(indexPath.section), let item = strongSelf.getItemAt(indexPath) else { return }
                    act.action(Section<ItemType, SectionType>(type: section.type, items: [item]))
                }
                
                if let img = act.image {
                    contextAct.image = img
                }
                
                if let color = act.backgroundColor {
                    contextAct.backgroundColor = color
                }
                
                return contextAct
            }
            return UISwipeActionsConfiguration(actions: actions)
        }
        return nil
    }

    open func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        
    }
    
    open func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    open func tableView(
        _ tableView: UITableView,
        moveRowAt sourceIndexPath: IndexPath,
        to destinationIndexPath: IndexPath
    ) {

    }

    // MARK: UITableViewDelegate implementation

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let section = getSectionAt(indexPath.section), let item = getItemAt(indexPath) else { return }
        self.tableFrame?.onItemSelected(item: item, sectionType: section.type)
    }

    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }

    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0
    }

    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0
    }

    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    open func tableView(
        _ tableView: UITableView,
        shouldIndentWhileEditingRowAt indexPath: IndexPath
    ) -> Bool {
        return true
    }

    open func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }

    open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

    }

    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

    }

}
