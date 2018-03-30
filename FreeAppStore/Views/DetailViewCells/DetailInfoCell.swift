//
//  DetailInfoCell.swift
//  FreeAppStore
//
//  Created by LeeYoung Woon on 2018. 3. 28..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

class DetailInfoCell: UITableViewCell {
    
    let languageDictionary = ["KO": "한국어", "EN": "영어"]
    
    var financeApp: FinanceApp? {
        didSet {
            salerLabel.text = financeApp?.artistName
            
            guard let fileSize = financeApp?.fileSizeBytes else { return }
            sizeLabel.text = Float(fileSize)?.capacityDisplay()
            
            guard let categoryStrings = financeApp?.genres else { return }
            categoryLabel.text = categoryStrings.count == 1 ? categoryStrings[0] : categoryStrings.reduce("", { (str1, str2) -> String in
                return str1 + " " + str2
            })
            
            supportedLabel.text = "iPhone"
            guard let languageStrings = financeApp?.languageCodesISO2A else { return }
            languageLabel.text = fetchLanguage(strings: languageStrings)
            contentLabel.text = financeApp?.trackContentRating
        }
    }
    
    @IBOutlet weak var salerLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var supportedLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    fileprivate func fetchLanguage(strings: [String]) -> String {
        var result: String = ""
        
        for str in strings {
            if let languageStr = languageDictionary[str] {
                result += "\(languageStr) "
            }
        }
        return result
    }
}
