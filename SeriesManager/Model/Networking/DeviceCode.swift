//
//  DeviceCode.swift
//  SeriesManager
//
//  Created by José Inácio Athayde Ferrarini on 10/08/17.
//  Copyright © 2017 José Inácio Athayde Ferrarini. All rights reserved.
//

import Foundation
import Arrow

struct DeviceCode {
    var deviceCode: String?
    var userCode: String?
    var verificationUrl: String?
    var expiresIn: Int?
    var interval: Int?
}

extension DeviceCode: ArrowParsable {
    
    mutating func deserialize(_ json: JSON) {
        deviceCode <-- json["device_code"]
        userCode <-- json["user_code"]
        verificationUrl <-- json["verification_url"]
        expiresIn <-- json["expires_in"]
        interval <-- json["interval"]
    }
    
}
