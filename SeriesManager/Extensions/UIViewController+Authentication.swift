//
//  ViewController+Authentication.swift
//  SeriesManager
//
//  Created by José Inácio Athayde Ferrarini on 12/08/17.
//  Copyright © 2017 José Inácio Athayde Ferrarini. All rights reserved.
//

import UIKit
import Glasgow

extension AppContextAware where Self: UIViewController, Self.AppContextType == AppContext {

    func shouldShowAuthentication() -> Bool {
        if let token = self.appContext?.token, token.isValid {
            return false
        }
        return true
    }
    
    func showAuthenticationFlow() {
        if let appContext = self.appContext, self.shouldShowAuthentication() {
            let authController = AuthenticationViewController(appContext: appContext)
            authController.title = "Login"
            let navigationController = UINavigationController(rootViewController: authController)
            self.appContext?.authenticationFlowViewController = navigationController
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    func dismissAuthenticationFlow() {
        if let viewController = self.appContext?.authenticationFlowViewController {
            viewController.dismiss(animated: true, completion: nil)
        }
    }
    
}
