//
//  AuthenticationView.swift
//  SeriesManager
//
//  Created by José Inácio Athayde Ferrarini on 12/08/17.
//  Copyright © 2017 José Inácio Athayde Ferrarini. All rights reserved.
//

import UIKit
import SnapKit
import WebKit

class AuthenticationView: UIView {
    
    // MARK: - Properties
    
    var webview: WKWebView = {
       return WKWebView(frame: .zero)
    }()
    
    var webviewDelegate = AuthenticationHelper()
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup
    
    func setup(with deviceCode: DeviceCode) {
        self.webview.navigationDelegate = self.webviewDelegate
        guard let urlString = deviceCode.verificationUrl else { return }
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        self.webview.load(request)
    }
    
}

extension AuthenticationView: ViewConfiguration {
    
    func setupConstraints() {
        webview.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.bottom.equalTo(self)
            make.right.equalTo(self)
        }
    }
    
    func buildViewHierarchy() {
        self.addSubview(webview)
    }
    
    func configureViews() {
        self.backgroundColor = UIColor.white
    }
    
}
