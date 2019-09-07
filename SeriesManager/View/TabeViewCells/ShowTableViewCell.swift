//
//  ShowTableViewCell.swift
//  SeriesManager
//
//  Created by José Inácio Athayde Ferrarini on 13/08/17.
//  Copyright © 2017 José Inácio Athayde Ferrarini. All rights reserved.
//

import UIKit
import Glasgow

class ShowTableViewCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel?
	@IBOutlet weak var yearLabel: UILabel?

}

extension ShowTableViewCell: Configurable {
    
    func setup(with show: Show) {
		self.titleLabel?.text = show.title
		self.yearLabel?.text = "\(show.year ?? 0)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
    
}
