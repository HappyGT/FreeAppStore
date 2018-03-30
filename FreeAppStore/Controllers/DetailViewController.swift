//
//  DetailViewController.swift
//  FreeAppStore
//
//  Created by LeeYoung Woon on 2018. 3. 27..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController, DownloadDelegate {
    var financeAppId: String? {
        didSet {
            guard let appId = financeAppId else { return }
            APIService.shared.fetchFinanceApps(appId: appId) { (financeApps) in
                self.financeApp = financeApps.first
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    var financeApp: FinanceApp?
    var rankingIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Download Delegate
    func didDownload() {
        let alertAction = UIAlertController(title: "다운로드", message: "다운로드 완료했습니다.", preferredStyle: .alert)
        
        alertAction.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alertAction, animated: true, completion: nil)
    }
    
    //MARK:- TableView Delegate
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            let cell = tableView.cellForRow(at: indexPath) as! DetailDescriptionCell
            cell.descriptionLabel.numberOfLines = 0
            
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        }
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {        //DetailMainCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailMainCell", for: indexPath) as! DetailMainCell
            cell.financeApp = self.financeApp
            cell.indexPath = self.rankingIndexPath
            cell.delegate = self
            
            return cell
        } else if indexPath.row == 1 { //DetailVersionCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailVersionCell", for: indexPath) as! DetailVersionCell
            cell.financeApp = self.financeApp
            
            return cell
        } else if indexPath.row == 2 { //DetailScreenshotCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailScreenshotCell", for: indexPath) as! DetailScreenshotCell
            cell.screenshotImageUrls = financeApp?.screenshotUrls
            
            return cell
        } else if indexPath.row == 3 { //DetailDescriptionCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailDescriptionCell", for: indexPath) as! DetailDescriptionCell
            cell.financeApp = self.financeApp
            
            return cell
        } else { //DetailInfoCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailInfoCell", for: indexPath) as! DetailInfoCell
            cell.financeApp = self.financeApp
            
            return cell
        }
    }
}
