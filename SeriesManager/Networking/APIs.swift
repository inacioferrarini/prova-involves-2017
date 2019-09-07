//
//  Apis.swift
//  SeriesManager
//
//  Created by José Inácio Athayde Ferrarini on 12/08/17.
//  Copyright © 2017 José Inácio Athayde Ferrarini. All rights reserved.
//

import UIKit

class APIs {

    lazy var security: SecurityApi = {
       let securityUrl = "https://api.trakt.tv"
       return SecurityApi(securityUrl)
    }()
    
    lazy var profile: ProfileApi = {
       let profileUrl = "https://api.trakt.tv"
       return ProfileApi(profileUrl)
    }()
    
    lazy var collection: CollectionApi = {
        let collectionUrl = "https://api.trakt.tv"
        return CollectionApi(collectionUrl)
    }()

}
