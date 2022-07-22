//
//  AlertProtocol.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public protocol AlertProtocol {
    
    @available(iOS 13, *)
    func changeUserInterfaceStyle(interfaceStyle: UIUserInterfaceStyle)
    
    func showAlert(message: String, predicate: (() -> Void)?)

    func showConfirm(
        title: String,
        message: String,
        isDestructive: Bool?,
        predicate: @escaping () -> Void
    )

    func showConfirm(
        title: String?,
        message: String?,
        options: [(title: String, isDestructive: Bool, isPreferred: Bool)],
        predicate: @escaping (String) -> Void
    )

    func showActionSheet(
        title: String?,
        message: String?,
        options: [(String, Bool)],
        predicate: @escaping (String) -> Void
    )

    func showTimePickerActionSheet(
        title: String?,
        message: String?,
        initialDate: Date?,
        predicate: @escaping (Date?) -> Void
    )

}
