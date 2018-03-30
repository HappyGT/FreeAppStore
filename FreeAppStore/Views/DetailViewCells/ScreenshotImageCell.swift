//
//  ScreenshotImageCell.swift
//  FreeAppStore
//
//  Created by LeeYoung Woon on 2018. 3. 28..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

class ScreenshotImageCell: UICollectionViewCell {
    
    var screenshotImageUrl: String? {
        didSet {
            screenshotImageView.loadImage(urlString: screenshotImageUrl)
        }
    }
    
    @IBOutlet weak var screenshotImageView: UIImageView!
}
