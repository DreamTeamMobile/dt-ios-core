//
//  InteractionManager.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import MessageUI
import UIKit

public class InteractionManager: NSObject, InteractionProtocol {

    // MARK: Fields

    private let subscription: SubscriptionManagerProtocol

    // MARK: Properties

    public var emailSubject: String {
        return (Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String) ?? ""
    }

    public var emailBody: String {
        return """


            ---------------
            Application: \(Bundle.main.infoDictionary?["CFBundleDisplayName"] ?? "")
            Device: \(UIDevice.current.modelName)
            iOS version: \(UIDevice.current.systemVersion)
            App version: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "") (\(Bundle.main.infoDictionary?[kCFBundleVersionKey as String] ?? ""))
            Products: \(getPurchasedProductsIds())
            """
    }

    // MARK: Init

    public init(
        subscription: SubscriptionManagerProtocol
    ) {
        self.subscription = subscription

        super.init()
    }

    // MARK: Private methods

    private func getPurchasedProductsIds() -> String {
        var purchasedProductIdentifiers = [String]()

        self.subscription.products.map({ $0.productIdentifier }).forEach { productIdentifier in
            let isPurchased = UserDefaults.standard.bool(forKey: productIdentifier)
            if isPurchased {
                purchasedProductIdentifiers.append(productIdentifier)
                print("Purchased: \(productIdentifier)")
            }
            else {
                print("Not purchased: \(productIdentifier)")
            }
        }

        return purchasedProductIdentifiers.joined(separator: ", ")
    }

    private func getLastPresentedControllerFor(
        _ viewController: UIViewController
    ) -> UIViewController {
        if let presented = viewController.presentedViewController {
            return getLastPresentedControllerFor(presented)
        }

        return viewController
    }

    private func present(controller: UIViewController) {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
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
        present(controller: vc)
    }

    public func share(_ activityItems: [Any]) {
        let vc = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(controller: vc)
    }

    public func share(
        _ activityItems: [Any],
        completion: UIActivityViewController.CompletionWithItemsHandler?
    ) {
        let vc = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        vc.completionWithItemsHandler = completion
        present(controller: vc)
    }

    public func openUrl(_ link: String) -> Bool {
        if let url = URL(string: link) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(
                    url,
                    options: [UIApplication.OpenExternalURLOptionsKey: Any](),
                    completionHandler: nil
                )
                return true
            }
        }

        return false
    }

    public func createEmail(email: String) -> Bool {
        if let url = URL(string: "mailto:\(email)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(
                    url,
                    options: [UIApplication.OpenExternalURLOptionsKey: Any](),
                    completionHandler: nil
                )
                return true
            }
        }

        return false
    }

    public func composeEmail(
        email: String,
        subject: String,
        body: String,
        attachment: AttachmentModel?
    ) -> Bool {
        if MFMailComposeViewController.canSendMail() {
            let mailComposerVC = MFMailComposeViewController()

            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients([email])
            mailComposerVC.setSubject(subject)
            mailComposerVC.setMessageBody(body, isHTML: false)

            if let a = attachment {
                mailComposerVC.addAttachmentData(a.data, mimeType: a.mimeType, fileName: a.fileName)
            }

            self.present(controller: mailComposerVC)

            return true
        }
        else {
            return sendEmailByLink(email: email, subject: self.emailSubject, body: self.emailBody)
        }
    }

    public func composeSupportEmail(email: String, attachment: AttachmentModel?) -> Bool {
        if MFMailComposeViewController.canSendMail() {
            let mailComposerVC = MFMailComposeViewController()

            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients([email])
            mailComposerVC.setSubject(self.emailSubject)
            mailComposerVC.setMessageBody(self.emailBody, isHTML: false)

            if let a = attachment {
                mailComposerVC.addAttachmentData(a.data, mimeType: a.mimeType, fileName: a.fileName)
            }

            present(controller: mailComposerVC)

            return true
        }
        else {
            return sendEmailByLink(email: email, subject: self.emailSubject, body: self.emailBody)
        }
    }

    public func changeIcon(_ name: String) {
        guard UIApplication.shared.supportsAlternateIcons else {
            return
        }

        UIApplication.shared.setAlternateIconName(name) { (error) in
            if let error = error {
                print("App icon failed to due to \(error.localizedDescription)")
            }
            else {
                print("App icon changed successfully.")
            }
        }
    }

    private func sendEmailByLink(email: String, subject: String, body: String) -> Bool {
        if let s = NSString(string: subject).addingPercentEncoding(withAllowedCharacters: []),
            let b = NSString(string: body).addingPercentEncoding(withAllowedCharacters: []),
            let url = URL(string: "mailto:\(email)?subject=\(s)&body=\(b)"),
            UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)

            return true
        }

        return false
    }

}

extension InteractionManager: MFMailComposeViewControllerDelegate {

    public func mailComposeController(
        _ controller: MFMailComposeViewController,
        didFinishWith result: MFMailComposeResult,
        error: Error?
    ) {
        controller.dismiss(animated: true, completion: nil)
    }

}
