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

class EpisodesListViewController: BaseTableViewController, AppContextAware {
    
    
    // MARK: - Properties
    
    var appContext: AppContext?
    
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let episodeFilterName = "*" + "" + "*"
        self.filterEpisodes(selectedSerie: self.appContext?.selectedSerie, name: episodeFilterName)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showAuthenticationFlow()
    }

    
    
    
    
    func filterEpisodes(selectedSerie: Serie?, name: String) {
        guard let selectedSerie = selectedSerie else { return }
        guard let dataSource = self.dataSource as? DataSourceFactory.EpisodesListDataSourceType else { return }
        guard let provider = dataSource.dataProvider as? CoreDataProvider<Episode> else { return }
        
        let ownerPredicate = NSPredicate(format: "owner = %@", selectedSerie)
        let namePredicate = NSPredicate(format: "name LIKE[cd] %@", name)
        provider.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [ownerPredicate, namePredicate])
        
        dataSource.refresh()
    }
    
    
    // MARK: - TableView setup
    
    override open func createDataSource() -> UITableViewDataSource? {
        guard let coreDataStack = self.appContext?.coreDataStack else { return nil }
        guard let tableView = self.tableView else { return nil }
        return DataSourceFactory.episodesListDataSource(with: tableView, stack: coreDataStack)
    }
    
    override open func createDelegate() -> UITableViewDelegate? {
//        guard let appContext = self.appContext else { return nil }
        guard let dataSource = self.dataSource as? DataSourceFactory.EpisodesListDataSourceType else { return nil }
        let onSelected: ((Episode) -> ()) = { [unowned self] (selectedEpisode) in
            print("Selected episode \(String(describing: selectedEpisode.name))")
//            appContext.selectedSerie = selectedSerie
//            self.performSegue(withIdentifier: EpisodesListViewController.simpleClassName(), sender: nil)
        }
        return DelegateFactory.episodesListDelegate(dataSource: dataSource, onSelected: onSelected)
    }

    
    
    
    

}
