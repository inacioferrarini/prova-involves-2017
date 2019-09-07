//
//  Serie.swift
//  SeriesManager
//
//  Created by José Inácio Athayde Ferrarini on 13/08/17.
//  Copyright © 2017 José Inácio Athayde Ferrarini. All rights reserved.
//

import UIKit
import Arrow

struct Show {
    
    
    // MARK: - Properties
    
    var title: String?
    var year: Int?
    
}

extension Show: ArrowParsable {
    
    mutating func deserialize(_ json: JSON) {
        title <-- json["show.title"]
        year <-- json["show.year"]
    }
    
}

extension Show: Equatable {}

func ==(lhs: Show, rhs: Show) -> Bool {
    return lhs.title == rhs.title &&
        rhs.year == lhs.year
}
