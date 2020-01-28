//
//  AlertManager.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

open class AlertManager: NSObject, AlertProtocol {

    // MARK: Fields
    
    private var pickerViewSource: PickerViewSource?
        
    // MARK: Methods
    
    public func present(viewController: UIViewController, alertPredicate: @escaping () -> UIViewController) {
        DispatchQueue.main.async {
            viewController.present(alertPredicate(), animated: true, completion: nil)
        }
    }
    
    public func showAlert(message: String, predicate: (() -> Void)? = nil) {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        
        present(viewController: viewController, alertPredicate: {
            let alert = UIAlertController.init(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction.init(title: AlertLocale.ok.localized, style: UIAlertAction.Style.default, handler: { alertAction -> Void in
                predicate?()
            }))
            return alert
        })
    }
    
    public func showConfirm(title: String, message: String, isDestructive: Bool?, predicate: @escaping () -> Void) {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        
        present(viewController: viewController, alertPredicate: {
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction.init(title: AlertLocale.cancel.localized, style: UIAlertAction.Style.cancel, handler: nil))
            
            let okStyle = (isDestructive ?? false) ? UIAlertAction.Style.destructive : UIAlertAction.Style.default
            let title = (isDestructive ?? false) ? AlertLocale.delete.localized : AlertLocale.ok.localized
            alert.addAction(UIAlertAction.init(title: title, style: okStyle, handler: { alertAction -> Void in
                predicate()
            }))
            return alert;
        })
    }
    
    public func showActionSheet(title: String?, message: String?, options: [(String, Bool)], predicate: @escaping (String) -> Void) {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        
        present(viewController: viewController, alertPredicate: {
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
            
            for option in options {
                alert.addAction(UIAlertAction(title: option.0, style: option.1 ? .destructive : .default, handler: { (action) in predicate(action.title ?? "") }))
            }
            
            alert.addAction(UIAlertAction(title: AlertLocale.cancel.localized, style: .cancel, handler: nil))
            
            alert.view.tintColor = UIView.appearance().tintColor
            
            return alert
        })
    }
    
    public func showTimePickerActionSheet(title: String?, message: String?, initialDate: Date?, predicate: @escaping (Date?) -> Void) {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        
        present(viewController: viewController, alertPredicate: {
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
                        
            let datePicker = UIDatePicker()
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            datePicker.datePickerMode = .time
            datePicker.minuteInterval = 5
            
            if initialDate != nil {
                datePicker.date = initialDate!
            } else {
                let calendar = Calendar.current
                var dateComponents = calendar.dateComponents([.month, .day, .year, .hour, .minute], from: datePicker.date)
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
            alert.view.tintColor = UIView.appearance().tintColor
            
            datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 10).isActive = true
            datePicker.rightAnchor.constraint(equalTo: alert.view.rightAnchor, constant: 0).isActive = true
            datePicker.leftAnchor.constraint(equalTo: alert.view.leftAnchor, constant: 0).isActive = true
            datePicker.heightAnchor.constraint(equalToConstant: 206).isActive = true
            
            alert.view.translatesAutoresizingMaskIntoConstraints = false
            alert.view.heightAnchor.constraint(equalToConstant: 382).isActive = true
            
            alert.addAction(UIAlertAction(title: AlertLocale.confirm.localized, style: .default, handler: { (action) in
                predicate(datePicker.date)
            }))
            alert.addAction(UIAlertAction(title: AlertLocale.clear.localized, style: .destructive, handler: { (action) in
                predicate(nil)
            }))
            alert.addAction(UIAlertAction(title: AlertLocale.cancel.localized, style: .cancel, handler: nil))
            
            return alert
        })
    }
    
}

class PickerViewSource: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private let items: [String]
    
    init(items: [String]) {
        self.items = items
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 32
    }
}
