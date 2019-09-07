//
//  ProfileApi.swift
//  SeriesManager
//
//  Created by José Inácio Athayde Ferrarini on 13/08/17.
//  Copyright © 2017 José Inácio Athayde Ferrarini. All rights reserved.
//

import UIKit
import Glasgow

class ProfileApi: AppBaseApi {

    func profile(clientId: String,
                 accessToken: String,
                 success: @escaping ((Profile?) -> Void),
                 failure: @escaping ((Error) -> Void)) {
        
        let targetUrl = "/users/settings"
        let transformer = ArrowTransformer<Profile>()
        let parameters: [String : Any]? = nil
        let headers: [String : String]? = ["Content-Type" : "application/json; charset=utf-8",
                       "trakt-api-key" : clientId,
                       "trakt-api-version" : "2",
                       "Authorization" : "Bearer \(accessToken)"]
        
        super.get(targetUrl,
                  responseTransformer: transformer,
                  parameters: parameters,
                  headers: headers,
                  success: success,
                  failure: failure,
                  retryAttempts: 30)
    }
    
}
