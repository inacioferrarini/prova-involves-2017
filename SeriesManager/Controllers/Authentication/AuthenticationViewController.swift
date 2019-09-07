//
//  AuthenticationViewController.swift
//  SeriesManager
//
//  Created by José Inácio Athayde Ferrarini on 12/08/17.
//  Copyright © 2017 José Inácio Athayde Ferrarini. All rights reserved.
//

import UIKit
import Glasgow

class AuthenticationViewController: UIViewController, AppContextAware {
    
    
    // MARK: - Properties
    
    var appContext: AppContext?
    let authenticationView = AuthenticationView()
    
    
    // MARK: - Initialization
    
    init(appContext: AppContext) {
        self.appContext = appContext
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = self.authenticationView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        authenticationView.webviewDelegate.onPageWillLoad = { [unowned self] (url, webview) -> Void in
            self.toast()
        }
        
        authenticationView.webviewDelegate.onPageDidLoaded = { [unowned self] (url, webview) -> Void in
            if let absoluteUrl = url?.absoluteString {
                if absoluteUrl.hasSuffix("/activate") {
                    let userCode = self.appContext?.deviceCode?.userCode ?? ""
                    let script = "document.getElementById('code').value = '\(userCode)';"
                    webview.evaluateJavaScript(script, completionHandler: nil)
                } else if absoluteUrl.hasSuffix("/activate/authorize") {
                    webview.loadedContent(completion: { [unowned self] (htmlString) in
                        if htmlString.range(of: "Woohoo!") != nil {
                            let expiresIn = self.appContext?.deviceCode?.expiresIn ?? 0
                            let interval = self.appContext?.deviceCode?.interval ?? 0
                            let deadline = Date(timeIntervalSinceNow: Double(expiresIn))
                            self.waitForToken(until: deadline, interval: interval)
                        }
                    })
                }
            }
            self.toastEnd()
        }
        
        self.showAuthenticationPage()
    }
    
    
    // MARK: - Actions
    
    func showAuthenticationPage() {
        guard let clientId = self.appContext?.clientID else { return }
        
        toast(withMessage: "Obtendo Device Code")
        self.appContext?.apis.security.deviceCode(clientId: clientId,
                                                  success: { [unowned self] (deviceCode) in
            self.appContext?.deviceCode = deviceCode
            if let deviceCode = deviceCode {
                self.authenticationView.setup(with: deviceCode)
            }
            self.toastEnd()
        }, failure: { (error) in
            self.toastEnd()
        })
    }
    
    func waitForToken(until deadline: Date, interval: Int) {
        if let token = self.appContext?.token, token.isValid {
            self.dismissAuthenticationFlow()
        }
        
        guard Date() < deadline else { return }
        
        self.toast(withSuccessMessage: "Validando Token!")
        guard let code = self.appContext?.deviceCode?.deviceCode else { return }
        guard let clientId = self.appContext?.clientID else { return }
        guard let clientSecret = self.appContext?.clientSecret else { return }
        
        self.appContext?.apis.security.token(code: code,
                                             clientId: clientId,
                                             clientSecret: clientSecret,
                                             success: { (token) in
            self.appContext?.token = token
            self.toastEnd()
            self.getProfile()
        }, failure: { (error) in
            self.waitForToken(until: deadline, interval: interval)
            self.toastEnd()
        })
    }
    
    func getProfile() {
        self.toast(withSuccessMessage: "Obtendo Perfil ...")
        
        guard let clientId = self.appContext?.clientID else { return }
        guard let accessToken = self.appContext?.token?.accessToken else { return }
        
        self.appContext?.apis.profile.profile(clientId: clientId,
                                              accessToken: accessToken,
                                              success: { (profile) in
            self.appContext?.profile = profile
            self.toastEnd()
            self.dismissAuthenticationFlow()
        }, failure: { (error) in
            self.toastEnd()
            self.dismissAuthenticationFlow()
        })
    }
    
}
