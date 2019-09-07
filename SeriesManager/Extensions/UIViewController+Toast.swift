//
//  UIViewController+Toast.swift
//  SeriesManager
//
//  Created by José Inácio Athayde Ferrarini on 12/08/17.
//  Copyright © 2017 José Inácio Athayde Ferrarini. All rights reserved.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    
    
    // MARK: - Toast
    
    public func toast() {
        SVProgressHUD.show()
    }
    
    public func toast(withMessage message: String) {
        SVProgressHUD.show(withStatus: message)
    }
    
    public func toast(withSuccessMessage message: String) {
        SVProgressHUD.showSuccess(withStatus: message)
    }
    
    public func toast(withErrorMessage errorMessage: String) {
        SVProgressHUD.showError(withStatus: errorMessage)
    }
    
    public func toastEnd() {
        SVProgressHUD.dismiss()
    }
    
}
