//
//  TableViewModel.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import DTCore
import Foundation
import Guise

class TableViewModel: BaseViewModel<TableInitObject> {

    // MARK: Properties

    private(set) var collectionFrame: CollectionFrame<TableItemVm>!

    private(set) var searchFrame: SearchFrame!

    // MARK: Dependencies

    private let provider: TableProviderProtocol

    // MARK: Init

    convenience required init() {
        self.init(provider: Guise.resolve()!)
    }

    init(
        provider: TableProviderProtocol
    ) {
        self.provider = provider
        
        super.init()
        
        self.searchFrame = SearchFrame(
            searchingHandler: { [weak self] request in self?.onSearchExecute(request) },
            cancellationHandler: { [weak self] in self?.onCancelExecute() },
            clearingHandler: { [weak self] in self?.onCancelExecute() }
        )
        self.collectionFrame = CollectionFrame<TableItemVm>(itemSelection: { [weak self] item in self?.onItemSelected(item) })
    }

    // MARK: Private methods

    private func onItemSelected(_ item: TableItemVm) {

    }

    private func onSearchExecute(_ searchRequest: String) {
        reloadData(searchRequest)
    }

    private func onCancelExecute() {
        reloadData()
    }

    private func reloadData(_ searchRequest: String = "") {
        let models = self.provider.getItems(searchRequest: searchRequest)
        self.collectionFrame.itemsSource = models.map { TableItemVm(title: $0) }
    }

    // MARK: Overrides

    override func start() {
        super.start()
        reloadData()
    }

}
