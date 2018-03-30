//
//  DetailDescriptionCell.swift
//  FreeAppStore
//
//  Created by LeeYoung Woon on 2018. 3. 28..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

class DetailDescriptionCell: UITableViewCell {
    
    var financeApp: FinanceApp? {
        didSet {
            guard let developer = financeApp?.artistName else { return }
            
            descriptionLabel.text = financeApp?.description
            developerLabel.attributedText = makeAttributedString(mainString: developer, subString: "개발자\n")
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    
    fileprivate func makeAttributedString(mainString: String, subString: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: subString, attributes: [NSAttributedStringKey.foregroundColor : UIColor.lightGray, NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 13)])
        
        attributedString.append(NSMutableAttributedString(string: mainString, attributes: [NSAttributedStringKey.foregroundColor : UIColor.kakaoYellow, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18)]))
        
        return attributedString
    }
    
}
