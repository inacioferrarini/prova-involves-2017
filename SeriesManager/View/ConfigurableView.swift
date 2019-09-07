//
//  ConfigurableView.swift
//  SeriesManager
//
//  Created by José Inácio Athayde Ferrarini on 12/08/17.
//  Copyright © 2017 José Inácio Athayde Ferrarini. All rights reserved.
//

import UIKit

protocol ViewConfiguration: class {
    func setupConstraints()
    func buildViewHierarchy()
    func configureViews()
    func setupViewConfiguration()
}

extension ViewConfiguration where Self: UIView {
    
    func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
}
