//
//  DetailVersionCell.swift
//  FreeAppStore
//
//  Created by LeeYoung Woon on 2018. 3. 28..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

class DetailVersionCell: UITableViewCell {
    
    var financeApp: FinanceApp? {
        didSet {
            guard let appVersion = financeApp?.version else { return }
            guard let appVersionDate = financeApp?.currentVersionReleaseDate else { return }
            versionLabel.text = "버전 \(appVersion)"
            
            let dateFormtter = DateFormatter()
            dateFormtter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            guard let date = dateFormtter.date(from: appVersionDate) else { return }
            versionDateLabel.text = date.timeAgoDisplay()
            
            releaseNotesLabel.text = financeApp?.releaseNotes
        }
    }
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var versionDateLabel: UILabel!
    @IBOutlet weak var releaseNotesLabel: UILabel!
}
