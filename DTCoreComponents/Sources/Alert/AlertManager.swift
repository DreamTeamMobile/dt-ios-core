//
//  AlertManager.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

open class AlertManager: NSObject, AlertProtocol {

    // MARK: Fields

    private var pickerViewSource: PickerViewSource?

    // MARK: Properties

    open var tintColor: UIColor?
    @available(iOS 13, *)
    private(set) lazy var interfaceStyle: UIUserInterfaceStyle = .unspecified

    // MARK: Private methods

    private func getLastPresentedControllerFor(
        _ viewController: UIViewController
    ) -> UIViewController {
        if let presented = viewController.presentedViewController {
            return getLastPresentedControllerFor(presented)
        }

        return viewController
    }

    // MARK: Methods

    public func present(alertPredicate: @escaping () -> UIAlertController) {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }

        let viewController = getLastPresentedControllerFor(rootViewController)
        let controller = alertPredicate()

        if let popover = controller.popoverPresentationController {
            let viCo =
                (viewController as? UINavigationController)?.topViewController ?? viewController
            let firstResponder = viCo.view.findFirstResponder()

            popover.sourceView =
                firstResponder ?? viCo.navigationController?.navigationBar ?? viCo.view
            popover.sourceRect =
                popover.sourceView?.frame
                ?? CGRect(
                    x: UIScreen.main.bounds.width / 2,
                    y: UIScreen.main.bounds.height / 2,
                    width: 0,
                    height: 0
                )
            popover.permittedArrowDirections = .any
        }

        DispatchQueue.main.async {
            viewController.present(controller, animated: true, completion: nil)
        }
    }
    
    @available(iOS 13, *)
    public func changeUserInterfaceStyle(interfaceStyle: UIUserInterfaceStyle) {
        self.interfaceStyle = interfaceStyle
    }

    public func showAlert(message: String, predicate: (() -> Void)? = nil) {
        present(alertPredicate: {
            let alert = UIAlertController.init(
                title: "",
                message: message,
                preferredStyle: UIAlertController.Style.alert
            )
            if #available(iOS 13.0, *), self.interfaceStyle != .unspecified  {
                alert.overrideUserInterfaceStyle = self.interfaceStyle
            }
            let okAction = UIAlertAction.init(
                title: AlertLocale.ok.localized,
                style: UIAlertAction.Style.default,
                handler: { alertAction -> Void in
                    predicate?()
                }
            )

            okAction.accessibilityIdentifier = okAction.title

            alert.addAction(okAction)

            return alert
        })
    }

    public func showConfirm(
        title: String,
        message: String,
        isDestructive: Bool?,
        predicate: @escaping () -> Void
    ) {
        present(alertPredicate: {
            let alert = UIAlertController.init(
                title: title,
                message: message,
                preferredStyle: UIAlertController.Style.alert
            )
            if #available(iOS 13.0, *), self.interfaceStyle != .unspecified  {
                alert.overrideUserInterfaceStyle = self.interfaceStyle
            }

            let cancelAction = UIAlertAction.init(
                title: AlertLocale.cancel.localized,
                style: UIAlertAction.Style.cancel,
                handler: nil
            )

            cancelAction.accessibilityIdentifier = cancelAction.title

            alert.addAction(cancelAction)

            let okStyle =
                (isDestructive ?? false)
                ? UIAlertAction.Style.destructive : UIAlertAction.Style.default
            let title =
                (isDestructive ?? false) ? AlertLocale.delete.localized : AlertLocale.ok.localized

            let okAction = UIAlertAction.init(
                title: title,
                style: okStyle,
                handler: { alertAction -> Void in
                    predicate()
                }
            )

            okAction.accessibilityIdentifier = okAction.title

            alert.addAction(okAction)

            return alert
        })
    }

    public func showConfirm(
        title: String?,
        message: String?,
        options: [(title: String, isDestructive: Bool, isPreferred: Bool)],
        predicate: @escaping (String) -> Void
    ) {
        present(alertPredicate: {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            if #available(iOS 13.0, *), self.interfaceStyle != .unspecified  {
                alert.overrideUserInterfaceStyle = self.interfaceStyle
            }
            
            var preferredAction: UIAlertAction? = nil
            for option in options {
                let action = UIAlertAction(
                    title: option.title,
                    style: option.isDestructive ? .destructive : .default,
                    handler: { action in
                        predicate(action.title ?? "")
                    }
                )

                action.accessibilityIdentifier = action.title

                preferredAction = option.isPreferred ? action : nil

                alert.addAction(action)
            }

            if let action = preferredAction {
                alert.preferredAction = action
            }

            return alert
        })
    }

    public func showActionSheet(
        title: String?,
        message: String?,
        options: [(String, Bool)],
        predicate: @escaping (String) -> Void
    ) {
        present(alertPredicate: {
            let alert = UIAlertController.init(
                title: title,
                message: message,
                preferredStyle: .actionSheet
            )
            if #available(iOS 13.0, *), self.interfaceStyle != .unspecified  {
                alert.overrideUserInterfaceStyle = self.interfaceStyle
            }
            
            alert.popoverPresentationController

            for option in options {
                let action = UIAlertAction(
                    title: option.0,
                    style: option.1 ? .destructive : .default,
                    handler: { (action) in predicate(action.title ?? "") }
                )

                action.accessibilityIdentifier = action.title

                alert.addAction(action)
            }

            let cancelAction = UIAlertAction(
                title: AlertLocale.cancel.localized,
                style: .cancel,
                handler: nil
            )

            cancelAction.accessibilityIdentifier = cancelAction.title

            alert.addAction(cancelAction)

            if let tintColor = self.tintColor {
                alert.view.tintColor = tintColor
            }

            return alert
        })
    }

    public func showTimePickerActionSheet(
        title: String?,
        message: String?,
        initialDate: Date?,
        predicate: @escaping (Date?) -> Void
    ) {
        present(alertPredicate: {
            let alert = UIAlertController.init(
                title: title,
                message: message,
                preferredStyle: .actionSheet
            )
            if #available(iOS 13.0, *), self.interfaceStyle != .unspecified  {
                alert.overrideUserInterfaceStyle = self.interfaceStyle
            }

            let datePicker = UIDatePicker()
            datePicker.accessibilityIdentifier = "datePicker"
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            datePicker.datePickerMode = .time
            datePicker.minuteInterval = 5

            if initialDate != nil {
                datePicker.date = initialDate!
            }
            else {
                let calendar = Calendar.current
                var dateComponents = calendar.dateComponents(
                    [.month, .day, .year, .hour, .minute],
                    from: datePicker.date
                )
                if var hour = dateComponents.hour, var minute = dateComponents.minute {
                    let intervalRemainder = minute % datePicker.minuteInterval
                    if intervalRemainder > 0 {
                        // need to correct the date
                        minute += datePicker.minuteInterval - intervalRemainder
                        if minute >= 60 {
                            hour += 1
                            minute -= 60
                        }

                        // update datecomponents
                        dateComponents.hour = hour
                        dateComponents.minute = minute

                        // get the corrected date
                        if let roundedDate = calendar.date(from: dateComponents) {
                            // update the datepicker
                            datePicker.date = roundedDate
                        }

                    }
                }
            }

            alert.view.addSubview(datePicker)

            if let tintColor = self.tintColor {
                alert.view.tintColor = tintColor
            }

            datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 10).isActive =
                true
            datePicker.rightAnchor.constraint(equalTo: alert.view.rightAnchor, constant: 0).isActive =
                true
            datePicker.leftAnchor.constraint(equalTo: alert.view.leftAnchor, constant: 0).isActive =
                true
            datePicker.heightAnchor.constraint(equalToConstant: 206).isActive = true

            alert.view.translatesAutoresizingMaskIntoConstraints = false
            alert.view.heightAnchor.constraint(equalToConstant: 382).isActive = true

            let confirmAction = UIAlertAction(
                title: AlertLocale.confirm.localized,
                style: .default,
                handler: { (action) in
                    predicate(datePicker.date)
                }
            )
            confirmAction.accessibilityIdentifier = confirmAction.title

            let clearAction = UIAlertAction(
                title: AlertLocale.clear.localized,
                style: .destructive,
                handler: { (action) in
                    predicate(nil)
                }
            )
            clearAction.accessibilityIdentifier = clearAction.title

            let cancelAction = UIAlertAction(
                title: AlertLocale.cancel.localized,
                style: .cancel,
                handler: nil
            )
            cancelAction.accessibilityIdentifier = cancelAction.title

            alert.addAction(confirmAction)
            alert.addAction(clearAction)
            alert.addAction(cancelAction)

            return alert
        })
    }

}

class PickerViewSource: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {

    private let items: [String]

    init(
        items: [String]
    ) {
        self.items = items
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }

    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return items[row]
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 32
    }
}
