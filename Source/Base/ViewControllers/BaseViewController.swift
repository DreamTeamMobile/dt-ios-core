//
//  BaseViewController.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

protocol BaseViCoProtocol {

    func setViewModel(viewModel: Any)

    func getViewModel() -> Any?
    
}

class BViewController: UIViewController, BaseViCoProtocol {
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .fullScreen
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.modalPresentationStyle = .fullScreen
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: BaseViCoProtocol

    func setViewModel(viewModel: Any) {
        
    }
    
    func getViewModel() -> Any? {
        return nil
    }
    
    // MARK: - Loader
    
    var loaderBackgroundColor: UIColor {
        get { return UIColor.black.withAlphaComponent(0.5) }
    }
    
    var loaderColor: UIColor {
        get { return UIColor.white }
    }

    func showLoader(animated: Bool = true) {
        let loaderView = self.loaderView()
        if loaderView.superview == nil {
            loaderView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(loaderView)

            NSLayoutConstraint.activate([
                loaderView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                loaderView.topAnchor.constraint(equalTo: self.view.topAnchor),
                loaderView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                loaderView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])

            if animated {
                loaderView.alpha = 0.0
                UIView.animate(withDuration: 0.3) {
                    loaderView.alpha = 1.0
                }
            } else {
                loaderView.alpha = 1.0
            }
        } else {
            view.bringSubviewToFront(loaderView)
        }
    }

    func hideLoader(animated: Bool = true) {
        let loaderView = self.loaderView()
        if loaderView.superview != nil {
            if (animated) {
                UIView.animate(withDuration: 0.3, animations: {
                    loaderView.alpha = 0.0
                }) { (finished) in
                    loaderView.removeFromSuperview()
                }
            } else {
                loaderView.removeFromSuperview()
            }
        }
    }

    func loaderView() -> UIView {
        let tag = 10001
        if let loaderView = view.viewWithTag(tag) {
            return loaderView
        }

        let loaderView = UIView(frame: view.bounds)
        loaderView.tag = tag
        loaderView.backgroundColor = self.loaderBackgroundColor
        loaderView.translatesAutoresizingMaskIntoConstraints = false

        let loader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        loader.color = self.loaderColor

        loaderView.addSubview(loader)

        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: loaderView.centerYAnchor).isActive = true
        loader.startAnimating()

        return loaderView
    }

    // MARK: - Keyboard

    private func registerKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    private func unregisterKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        let keyboardHeight = keyboardInfo?.cgRectValue.size.height ?? 0.0
        keyboardHeightDidChanged(keyboardHeight)
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        keyboardHeightDidChanged(0.0)
    }

    @objc private func keyboardWillChangeFrame(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        let keyboardHeight = keyboardInfo?.cgRectValue.size.height ?? 0.0
        keyboardWillChangeFrame(keyboardHeight)
    }

    func keyboardHeightDidChanged(_ height: CGFloat) {
        
    }

    func keyboardWillChangeFrame(_ height: CGFloat) {

    }
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

// MARK: - BaseViewController

class BaseViewController<T: BViewModel>: BViewController {

    var viewModel: T?

    // MARK: Methods
        
    func bindLoadingState() {
        self.viewModel?.$isLoading.bindAndFire { [weak self] old, new in
            if new {
                self?.showLoader()
            } else {
                self?.hideLoader()
            }
        }
    }

    // MARK: BaseViCoProtocol

    override func setViewModel(viewModel: Any) {
        self.viewModel = viewModel as? T
    }
    
    override func getViewModel() -> Any? {
        return self.viewModel
    }

    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        bindLoadingState()
        self.viewModel?.start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.viewAppearing()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel?.viewAppeared()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel?.viewDisappearing()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewModel?.viewDisappeared()
    }

}
