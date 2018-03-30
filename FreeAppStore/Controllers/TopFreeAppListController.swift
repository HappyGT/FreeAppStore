//
//  FinanceListController.swift
//  FreeAppStore
//
//  Created by LeeYoung Woon on 2018. 3. 27..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

class TopFreeAppListController: UITableViewController {
    
    let cellId = "financeCell"
    let segueId = "financeSegue"
    var topFreeApps = [TopFreeApp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTopFreeApps()
    }
    
    fileprivate func fetchTopFreeApps() {
        APIService.shared.fetchTopFreeApps { (topFreeApps) in
            self.topFreeApps = topFreeApps
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK:- TableView Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topFreeApps.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FinanceCell
        
        cell.freeApp = topFreeApps[indexPath.row]
        cell.appRankingIndexPath = indexPath
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueId {
            guard let detailViewController = segue.destination as? DetailViewController else { return }
            guard let cell = sender as? FinanceCell else { return }
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            
            detailViewController.financeAppId = cell.freeApp?.id
            detailViewController.rankingIndexPath = indexPath
        }
    }
}
