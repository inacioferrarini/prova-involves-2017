//    The MIT License (MIT)
//
//    Copyright (c) 2017 Inácio Ferrarini
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
//

import UIKit
import Glasgow
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appContext = AppContext()
    
    var documentsUrl: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    }
    
    var tokenFilePath: String? {
        return self.documentsUrl?.appendingPathComponent("apitoken.data").path
    }
    
    var profileFilePath: String? {
        return self.documentsUrl?.appendingPathComponent("profile.data").path
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setMinimumDismissTimeInterval(2)
		
        if self.appContext.token == nil {
            self.appContext.token = Token()
        }
        self.restoreToken(into: self.appContext)
        self.restoreProfile(into: self.appContext)
        
        self.inject(appContext: self.appContext, in: self.window?.rootViewController)
        
        return true
    }

    func inject(appContext: AppContext, in rootViewController: UIViewController?) {
        guard let navigationController = self.window?.rootViewController as? UINavigationController else { return }
        guard let topViewController = navigationController.viewControllers.last as? SeriesListViewController else { return }
        topViewController.appContext = appContext
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        try? appContext.coreDataStack.saveContext()
        if let tokenFilePath = self.tokenFilePath {
            self.appContext.token?.save(to: tokenFilePath)
        }
        if let profileFilePath = self.profileFilePath {
            self.appContext.profile?.save(to: profileFilePath)
        }
    }
    
    func restoreToken(into appContext: AppContext) {
        if let tokenFilePath = self.tokenFilePath {
            appContext.token?.load(from: tokenFilePath)
        }
    }
    
    func restoreProfile(into appContext: AppContext) {
        if let profileFilePath = self.profileFilePath {
            appContext.profile?.load(from: profileFilePath)
        }
    }
    
}
