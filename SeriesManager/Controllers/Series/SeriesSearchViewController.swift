//
//  SeriesSearchViewController.swift
//  SeriesManager
//
//  Created by José Inácio Athayde Ferrarini on 13/08/17.
//  Copyright © 2017 José Inácio Athayde Ferrarini. All rights reserved.
//

import UIKit
import Glasgow

class SeriesSearchViewController: BaseTableViewController, AppContextAware {
    
    
    // MARK: - Properties
    
    var appContext: AppContext?
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    // MARK: - TableView setup
	
	override func setupTableView() {
		super.setupTableView()
		self.tableView?.allowsMultipleSelection = true
	}
	
    override open func createDataSource() -> UITableViewDataSource? {
        guard let tableView = self.tableView else { return nil }
        return DataSourceFactory.seriesSearchListDataSource(with: tableView, shows: [])
    }
    
    
    // MARK: - Helper methods
    
    func dismiss() {
        if let navigationController = self.parent as? UINavigationController {
            navigationController.dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss()
    }
    
    @IBAction func apply(_ sender: UIBarButtonItem) {
		if let indexPaths = self.tableView?.indexPathsForSelectedRows,
			let dataSource = self.dataSource as? DataSourceFactory.SeriesSearchListDataSourceType {
			
			var shows = [Show]()
			for indexPath in indexPaths {
				guard let show = dataSource.object(at: indexPath) else { continue }
				shows.append(show)
			}
			
			// Adds to user
			
			self.dismiss()
		}
		
    }
    
}

extension SeriesSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchExpression = searchBar.text ?? ""
        
        self.toast(withSuccessMessage: "Buscando Séries ...")
        
        guard let clientId = self.appContext?.clientID else { return }

        self.appContext?.apis.collection.searchShow(query: searchExpression,
                                                    clientId: clientId,
                                                    success: { (shows) in
            
		    if let shows = shows, let dataSource = self.dataSource as? DataSourceFactory.SeriesSearchListDataSourceType {
				dataSource.dataProvider.update(rows: shows)
				DispatchQueue.main.async {
					dataSource.refresh()
					self.toastEnd()
				}
            }
        }, failure: { (error) in
            self.toastEnd()
        })
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
		if let dataSource = self.dataSource as? DataSourceFactory.SeriesSearchListDataSourceType {
			dataSource.dataProvider.update(rows: [])
			DispatchQueue.main.async {
				dataSource.refresh()
				self.toastEnd()
			}
		}
    }
	
}
