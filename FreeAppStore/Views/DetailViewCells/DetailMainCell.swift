//
//  DetailMainCell.swift
//  FreeAppStore
//
//  Created by LeeYoung Woon on 2018. 3. 28..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

protocol DownloadDelegate {
    func didDownload()
}

class DetailMainCell: UITableViewCell {
    
    var delegate: DownloadDelegate?
    
    var indexPath: IndexPath? {
        didSet {
            guard let ranking = indexPath?.row else { return }
            
            appRatingLabel.attributedText = makeAttributedString(mainString: "#\(ranking + 1)\n", subString: "금융")
            appRatingLabel.numberOfLines = 2
        }
    }
    
    var financeApp: FinanceApp? {
        didSet {
            guard let app = financeApp else { return }
        
            appImageView.loadImage(urlString: app.artworkUrl100)
            appImageView.layer.cornerRadius = 10
            
            nameLabel.text = app.trackName
            developerLabel.text = app.artistName
            
            if let userRating = app.averageUserRating, let ratingCount = app.userRatingCount {
                userRatingLabel.attributedText = makeAttributedString(mainString: "\(userRating)\n", subString: "\(ratingCount)개의 평가")
                userRatingLabel.numberOfLines = 2
            }
            if let contentRating = app.trackContentRating {
                contentRatingLabel.attributedText = makeAttributedString(mainString: "\(contentRating)\n", subString: "연령")
                contentRatingLabel.numberOfLines = 2
            }
        }
    }
    
    
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton! {
        didSet {
            downloadButton.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var userRatingLabel: UILabel!
    @IBOutlet weak var appRatingLabel: UILabel!
    @IBOutlet weak var contentRatingLabel: UILabel!
    
    @IBAction func downloadAction(_ sender: Any) {
        self.delegate?.didDownload()
    }
    
    fileprivate func makeAttributedString(mainString: String, subString: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: mainString, attributes: [NSAttributedStringKey.foregroundColor : UIColor.gray, NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 24)])
        
        attributedString.append(NSMutableAttributedString(string: subString, attributes: [NSAttributedStringKey.foregroundColor : UIColor.lightGray, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13)]))
        
        return attributedString
    }
    
}
