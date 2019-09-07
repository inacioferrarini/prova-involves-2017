//
//  TokenApi.swift
//  SeriesManager
//
//  Created by José Inácio Athayde Ferrarini on 10/08/17.
//  Copyright © 2017 José Inácio Athayde Ferrarini. All rights reserved.
//

import UIKit
import Glasgow

class SecurityApi: AppBaseApi {
    
    func deviceCode(clientId: String,
                    success: @escaping ((DeviceCode?) -> Void),
                    failure: @escaping ((Error) -> Void)) {
        
        let targetUrl = "/oauth/device/code"
        let transformer = ArrowTransformer<DeviceCode>()
        let parameters = ["client_id" : clientId]
        let headers = ["Content-Type" : "application/json; charset=utf-8"]
        
        super.post(targetUrl,
                   responseTransformer: transformer,
                   parameters: parameters,
                   headers: headers,
                   success: success,
                   failure: failure,
                   retryAttempts: 30)
    }
    
    func token(code: String,
               clientId: String,
               clientSecret: String,
               success: @escaping ((Token?) -> Void),
               failure: @escaping ((Error) -> Void)) {
        
        let targetUrl = "/oauth/device/token"
        let transformer = ArrowTransformer<Token>()
        let parameters = ["code" : code,
                          "client_id" : clientId,
                          "client_secret" : clientSecret]
        let headers = ["Content-Type" : "application/json; charset=utf-8"]
        
        self.post(targetUrl,
                  responseTransformer: transformer,
                  parameters: parameters,
                  headers: headers,
                  success: success,
                  failure: failure,
                  retryAttempts: 30)
    }
    
}
