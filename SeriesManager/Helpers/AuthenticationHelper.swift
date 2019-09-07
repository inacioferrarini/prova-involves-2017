//
//  AuthenticationHelper.swift
//  SeriesManager
//
//  Created by José Inácio Athayde Ferrarini on 12/08/17.
//  Copyright © 2017 José Inácio Athayde Ferrarini. All rights reserved.
//

import UIKit
import WebKit

class AuthenticationHelper: NSObject, WKNavigationDelegate {

    
    // MARK: - Properties
    
    var currentUrl: URL?
    var onPageWillLoad: ((URL?, WKWebView) -> Void)?
    var onPageDidLoaded: ((URL?, WKWebView) -> Void)?
    
    
    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.onPageWillLoad?(currentUrl, webView)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.onPageDidLoaded?(currentUrl, webView)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        self.currentUrl = navigationAction.request.url
        decisionHandler(.allow)
    }
    
}
