//
//  InteractionManager.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit
import MessageUI

public class InteractionManager: NSObject, InteractionProtocol {
        
    // MARK: Properties
    
    var emailSubject: String {
        get {
            return (Bundle.main.infoDictionary?["CFBundleName"] as? String) ?? ""
        }
    }
    
    var emailBody: String {
        get {
            return """


---------------
Application: \(Bundle.main.infoDictionary?["CFBundleName"] ?? "")
Device: \(UIDevice.current.modelName)
iOS version: \(UIDevice.current.systemVersion)
App version: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "") (\(Bundle.main.infoDictionary?[kCFBundleVersionKey as String] ?? ""))
"""
            }
        }
    
    // MARK: Private methods
        
    private func getLastPresentedControllerFor(_ viewController: UIViewController) -> UIViewController {
        if let presented = viewController.presentedViewController {
            return getLastPresentedControllerFor(presented)
        }
        
        return viewController
    }
    
    private func present(controller: UIViewController) {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        let viewController = getLastPresentedControllerFor(rootViewController)
        
        DispatchQueue.main.async {
            viewController.present(controller, animated: true, completion: nil)
        }
    }
    
    // MARK: Methods
    
    public func copyToClipboard(_ text: String) {
        UIPasteboard.general.string = text
    }
    
    public func shareText(_ text: String) {
        let vc = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    
    public func openUrl(_ link: String) -> Bool {
        if let url = URL(string: link) {
            if (UIApplication.shared.canOpenURL(url)) {
                UIApplication.shared.open(url, options: [UIApplication.OpenExternalURLOptionsKey : Any](), completionHandler: nil)
                return true
            }
        }
        
        return false
    }
    
    public func createEmail(email: String) -> Bool {
        if let url = URL(string: "mailto:\(email)") {
            if (UIApplication.shared.canOpenURL(url)) {
                UIApplication.shared.open(url, options: [UIApplication.OpenExternalURLOptionsKey : Any](), completionHandler: nil)
                return true
            }
        }
        
        return false
    }
    
    public func composeEmail(email: String, subject: String, body: String) {
        if MFMailComposeViewController.canSendMail() {
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients([email])
            mailComposerVC.setSubject(subject)
            mailComposerVC.setMessageBody(body, isHTML: false)
            self.present(controller: mailComposerVC)
        }
    }
    
    public func composeSupportEmail(email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients([email])
            mailComposerVC.setSubject(self.emailSubject)
            mailComposerVC.setMessageBody(self.emailBody, isHTML: false)
            present(controller: mailComposerVC)
        }
    }
    
    public func changeIcon(_ name: String) {
        guard UIApplication.shared.supportsAlternateIcons else {
            return;
        }
        
        UIApplication.shared.setAlternateIconName(name) { (error) in
            if let error = error {
                print("App icon failed to due to \(error.localizedDescription)")
            } else {
                print("App icon changed successfully.")
            }
        }
    }
    
}

extension InteractionManager: MFMailComposeViewControllerDelegate {
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
