//    The MIT License (MIT)
//
//    Copyright (c) 2017 Inácio Ferrarini
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
//

import UIKit
import Glasgow

class SeriesListViewController: BaseTableViewController, AppContextAware {
    
    
    // MARK: - Properties
    
    var appContext: AppContext?
    
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let dataSource = self.dataSource as? DataSourceFactory.SeriesListDataSourceType else { return }
        dataSource.refresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showAuthenticationFlow()
    }
    
    
    // MARK: - Data Synchronization
    
    override func shouldSyncData() -> Bool {
        return true
    }
    
    override func performDataSync() {
        self.toast(withSuccessMessage: "Obtendo Séries ...")
        
        guard let userId = self.appContext?.profile?.username else { return }
        guard let clientId = self.appContext?.clientID else { return }
        
        self.appContext?.apis.collection.shows(userId: userId,
                                               clientId: clientId,
                                               success: { (shows) in
            self.processShows(shows: shows)
            self.toastEnd()
        }, failure: { (error) in
            self.toastEnd()
        })
    }
    
    func processShows(shows: [Show]?) {
        guard let context = self.appContext?.coreDataStack.managedObjectContext else { return }
        guard let shows = shows else { return }
        
        for show in shows {
            guard let name = show.title else { continue }
            _ = Serie.serie(named: name, year: "\(show.year ?? 0)", in: context)
        }
        try? self.appContext?.coreDataStack.saveContext()
        DispatchQueue.main.async {
            guard let dataSource = self.dataSource as? DataSourceFactory.SeriesListDataSourceType else { return }
            dataSource.refresh()
        }
    }
    
    
    // MARK: - TableView setup
    
    override open func createDataSource() -> UITableViewDataSource? {
        guard let coreDataStack = self.appContext?.coreDataStack else { return nil }
        guard let tableView = self.tableView else { return nil }
        return DataSourceFactory.seriesListDataSource(with: tableView, stack: coreDataStack)
    }
    
    override open func createDelegate() -> UITableViewDelegate? {
        guard let appContext = self.appContext else { return nil }
        guard let dataSource = self.dataSource as? DataSourceFactory.SeriesListDataSourceType else { return nil }
        let onSelected: ((Serie) -> ()) = { [unowned self] (selectedSerie) in
            appContext.selectedSerie = selectedSerie
            self.performSegue(withIdentifier: EpisodesListViewController.simpleClassName(), sender: nil)
        }
        return DelegateFactory.seriesListDelegate(dataSource: dataSource, onSelected: onSelected)
    }
    
    
    // MARK: - Actions
    
    @IBAction func addSerie(_ sender: UIBarButtonItem) {
        let viewController = SeriesSearchViewController.simpleClassName()
        self.performSegue(withIdentifier: viewController, sender: nil)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodesListViewController {
            destination.appContext = self.appContext
        } else if let destination = segue.destination as? UINavigationController {
            if let destination = destination.topViewController as? SeriesSearchViewController {
                destination.appContext = self.appContext
            }
        }
    }
    
}
