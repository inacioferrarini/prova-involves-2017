//
//  CollectionApi.swift
//  SeriesManager
//
//  Created by José Inácio Athayde Ferrarini on 13/08/17.
//  Copyright © 2017 José Inácio Athayde Ferrarini. All rights reserved.
//

import UIKit
import Glasgow

class CollectionApi: AppBaseApi {
    
    func shows(userId: String,
               clientId: String,
               success: @escaping (([Show]?) -> Void),
               failure: @escaping ((Error) -> Void)) {
        
        let targetUrl = "/users/:userId/collection/shows"
            .replacingOccurrences(of: ":userId", with: userId)
        let transformer = ArrowArrayTransformer<Show>()
        let parameters: [String : Any]? = nil
        let headers: [String : String]? = ["Content-Type" : "application/json; charset=utf-8",
                                           "trakt-api-key" : clientId,
                                           "trakt-api-version" : "2"]
        
        super.get(targetUrl,
                  responseTransformer: transformer,
                  parameters: parameters,
                  headers: headers,
                  success: success,
                  failure: failure,
                  retryAttempts: 30)
    }
    
    func searchShow(query: String,
                    clientId: String,
                    success: @escaping (([Show]?) -> Void),
                    failure: @escaping ((Error) -> Void)) {
        
        let targetUrl = "/search/show?query=:query"
            .replacingOccurrences(of: ":query", with: query)
        let transformer = ArrowArrayTransformer<Show>()
        let parameters: [String : Any]? = nil
        let headers: [String : String]? = ["Content-Type" : "application/json; charset=utf-8",
                                           "trakt-api-key" : clientId,
                                           "trakt-api-version" : "2"]
        
        super.get(targetUrl,
                  responseTransformer: transformer,
                  parameters: parameters,
                  headers: headers,
                  success: success,
                  failure: failure,
                  retryAttempts: 30)
    }
    
}
