//
//  BaseVC.swift
//  StubhubTask
//
//  Created by Hesham Donia on 06/08/2022.
//

import UIKit
import iProgressHUD
import SwiftMessages

class BaseVC: UIViewController {
                
    override func viewDidLoad() {
        super.viewDidLoad()
        iProgressHUD.sharedInstance().attachProgress(toView: self.view)
    }
    
    @objc func backFromPresent() {
        dismiss(animated: true)
    }
    
    func showLoader() {
        view.showProgress()
    }
    
    func hideLoader() {
        view.dismissProgress()
    }
    
    func showErrorMessage(text: String?) {
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(Theme.error, iconStyle: IconStyle.none)
        view.configureDropShadow()
        view.button?.isHidden = true
        view.configureContent(title: nil, body: text, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: nil)
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        var config = SwiftMessages.Config.init()
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        SwiftMessages.show(config: config, view: view)
    }

}
