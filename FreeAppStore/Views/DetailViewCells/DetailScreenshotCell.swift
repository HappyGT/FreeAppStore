//
//  DetailScreenshotCell.swift
//  FreeAppStore
//
//  Created by LeeYoung Woon on 2018. 3. 28..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

class DetailScreenshotCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let collectionCellId = "screenshotImageCell"
    
    var screenshotImageUrls: [String]? {
        didSet {
            screenshotCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var screenshotCollectionView: UICollectionView!
    
    //MARK:- CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshotImageUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellId, for: indexPath) as! ScreenshotImageCell
        
        cell.screenshotImageUrl = self.screenshotImageUrls?[indexPath.item]
        
        return cell
    }
}
