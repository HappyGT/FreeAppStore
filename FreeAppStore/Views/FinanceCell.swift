//
//  FinanceCell.swift
//  FreeAppStore
//
//  Created by LeeYoung Woon on 2018. 3. 27..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

class FinanceCell: UITableViewCell {
    
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appCategoryLabel: UILabel!
    @IBOutlet weak var appRankingLabel: UILabel!
    
    var freeApp: TopFreeApp? {
        didSet {
            guard let application = freeApp else { return }
            
            appImageView.loadImageWithCache(urlString: application.imageUrl)
            appImageView.layer.cornerRadius = 10
            
            appNameLabel.text = application.name
            appCategoryLabel.text = application.category
        }
    }
    
    var appRankingIndexPath: IndexPath? {
        didSet {
            guard let indexPath = appRankingIndexPath else { return }
            appRankingLabel.text = "\(indexPath.row + 1)"
        }
    }
}

