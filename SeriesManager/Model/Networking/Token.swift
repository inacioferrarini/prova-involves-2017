//
//  Token.swift
//  SeriesManager
//
//  Created by José Inácio Athayde Ferrarini on 11/08/17.
//  Copyright © 2017 José Inácio Athayde Ferrarini. All rights reserved.
//

import Foundation
import Arrow

struct Token {
    
    
    // MARK: - Properties
    
    var accessToken: String?
    var tokenType: TokenType?
    var expiresIn: Date?
    var refreshToken: String?
    var scope: Scope?
    var createdAt: Date?
    
    var isValid: Bool {
        get {
            guard accessToken != nil else { return false }
            guard let date = expiresIn, date < Date() else { return false }
            return true
        }
    }
    
    
    // MARK: - Archiving Support
    
    func save(to archive: String) {
        var dataDict = [String : Any]()
        if let accessToken = self.accessToken {
            dataDict["accessToken"] = accessToken
        }
        if let tokenType = self.tokenType {
            dataDict["tokenType"] = tokenType.rawValue
        }
        if let expiresIn = self.expiresIn {
            dataDict["expiresIn"] = expiresIn
        }
        if let refreshToken = self.refreshToken {
            dataDict["refreshToken"] = refreshToken
        }
        if let scope = self.scope {
            dataDict["scope"] = scope.rawValue
        }
        if let createdAt = self.createdAt {
            dataDict["createdAt"] = createdAt
        }
        
        NSKeyedArchiver.archiveRootObject(dataDict, toFile: archive)
    }
    
    mutating func load(from archive: String) {
        guard let dataDict = NSKeyedUnarchiver.unarchiveObject(withFile: archive) as? [String : Any] else { return }
        if let accessToken = dataDict["accessToken"] as? String {
            self.accessToken = accessToken
        }
        if let tokenType = dataDict["tokenType"] as? String {
            self.tokenType = TokenType(rawValue: tokenType)
        }
        if let expiresIn = dataDict["expiresIn"] as? Date {
            self.expiresIn = expiresIn
        }
        if let refreshToken = dataDict["refreshToken"] as? String {
            self.refreshToken = refreshToken
        }
        if let scope = dataDict["scope"] as? String {
            self.scope = Scope(rawValue: scope)
        }
        if let createdAt = dataDict["createdAt"] as? Date {
            self.createdAt = createdAt
        }
    }
    
}

extension Token: ArrowParsable {
    
    mutating func deserialize(_ json: JSON) {
        accessToken <-- json["access_token"]
        tokenType <-- json["token_type"]
        expiresIn <-- json["expires_in"]
        refreshToken <-- json["refresh_token"]
        scope <-- json["scope"]
        createdAt <-- json["created_at"]
    }
    
}
