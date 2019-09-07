//
//  Profile.swift
//  SeriesManager
//
//  Created by José Inácio Athayde Ferrarini on 13/08/17.
//  Copyright © 2017 José Inácio Athayde Ferrarini. All rights reserved.
//

import Foundation
import Arrow

struct Profile {
    
    
    // MARK: - Properties
    
    var username: String?
    
    
    // MARK: - Archiving Support
    
    func save(to archive: String) {
        var dataDict = [String : Any]()
        if let username = self.username {
            dataDict["username"] = username
        }
        
        NSKeyedArchiver.archiveRootObject(dataDict, toFile: archive)
    }
    
    mutating func load(from archive: String) {
        guard let dataDict = NSKeyedUnarchiver.unarchiveObject(withFile: archive) as? [String : Any] else { return }
        if let username = dataDict["username"] as? String {
            self.username = username
        }
    }
    
}

extension Profile: ArrowParsable {

    mutating func deserialize(_ json: JSON) {
        username <-- json["user.username"]
    }
    
}
