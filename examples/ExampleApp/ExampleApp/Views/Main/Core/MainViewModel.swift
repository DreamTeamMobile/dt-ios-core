//
//  MainViewModel.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeam Apps. All rights reserved.
//

import DTCore
import Foundation
import Guise

class MainViewModel: BaseViewModel<MainInitObject> {

    // MARK: Properties

    private(set) var searchAndTableButton: ButtonFrame!

    private(set) var inputButton: ButtonFrame!

    private(set) var multipleButton: ButtonFrame!

    // MARK: Dependencies

    private let router: RouterProtocol

    // MARK: Init

    convenience required init() {
        self.init(router: Guise.resolve()!)
    }

    required init(
        router: RouterProtocol
    ) {
        self.router = router

        super.init()

        self.searchAndTableButton = ButtonFrame(
            title: MainLocale.Buttons.search.localized,
            onExecute: { [weak self] in self?.onSearchAndTableExecute() }
        )
        self.inputButton = ButtonFrame(
            title: MainLocale.Buttons.input.localized,
            onExecute: { [weak self] in self?.onInputExecute() }
        )
        self.multipleButton = ButtonFrame(
            title: MainLocale.Buttons.multiple.localized,
            onExecute: { [weak self] in self?.onMultipleExecute() }
        )
    }

    // MARK: Private methods

    private func onSearchAndTableExecute() {
        self.router.navigateTo(
            vmType: TableViewModel.self,
            initObj: TableInitObject(),
            navigationType: .push,
            completion: nil
        )
    }

    private func onInputExecute() {
        self.router.navigateTo(
            vmType: InputViewModel.self,
            initObj: InputInitObj(),
            navigationType: .push,
            completion: nil
        )
    }

    private func onMultipleExecute() {
        self.router.navigateTo(
            vmType: MultipleViewModel.self,
            initObj: MultipleInitObject(),
            navigationType: .push,
            completion: nil
        )
    }

}
