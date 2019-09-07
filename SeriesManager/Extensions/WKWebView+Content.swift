//
//  WKWebView+Content.swift
//  SeriesManager
//
//  Created by José Inácio Athayde Ferrarini on 12/08/17.
//  Copyright © 2017 José Inácio Athayde Ferrarini. All rights reserved.
//

import Foundation
import WebKit

extension WKWebView {
    
    func loadedContent(completion: @escaping ((String) -> Void)) {
        let script = "document.documentElement.outerHTML.toString()"
        self.evaluateJavaScript(script) { (html, error) in
            let htmlString = html as? String ?? ""
            completion(htmlString)
        }
    }
    
}
