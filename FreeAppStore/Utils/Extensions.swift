//
//  Extensions.swift
//  FreeAppStore
//
//  Created by LeeYoung Woon on 2018. 3. 27..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        
        let quotient: Int
        let unit: String
        
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "초"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "분"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "시간"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "일"
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "주"
        } else {
            quotient = secondsAgo / month
            unit = "달"
        }
        
        return "\(quotient)\(unit) 전"
    }
}

extension Float {
    func capacityDisplay() -> String {
        let byte = self
        
        let kiloByte: Float = 1000.0
        let megaByte: Float = 1000000.0
        
        let capacity: Float
        let unit: String
        
        if byte < kiloByte {
            capacity = byte
            unit = "B"
        } else if byte < megaByte {
            capacity = byte / kiloByte
            unit = "KB"
        } else {
            capacity = byte / megaByte
            unit = "MB"
        }
        
        let floatCapacity = String(format: "%.1f", capacity)
        return "약 \(floatCapacity)\(unit)"
    }
}

extension UIColor {
    static let kakaoYellow: UIColor = {
        return UIColor(red: 254/255, green: 217/255, blue: 11/255, alpha: 1)
    }()
}

var imageCache = [String: Data]()
extension UIImageView {
    func loadImageWithCache(urlString: String?) {
        var lastURLUsedToLoadImage: String?
        guard let urlString = urlString else { return }
        
        lastURLUsedToLoadImage = urlString
        
        self.image = nil
        if let cachedImage = imageCache[urlString] {
            self.image = UIImage(data: cachedImage)
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global(qos: .background).async {
            if url.absoluteString != lastURLUsedToLoadImage {
                return
            }
            
            do {
                let imageData = try Data.init(contentsOf: url)
                imageCache[url.absoluteString] = imageData
                let photoImage = UIImage(data: imageData)
                
                DispatchQueue.main.async {
                    self.image = photoImage
                }
            } catch let err {
                print(err.localizedDescription)
            }
        }
    }
    
    func loadImage(urlString: String?) {
        guard let urlString = urlString else { return }
        
        self.image = nil
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global(qos: .background).async {
            do {
                let imageData = try Data.init(contentsOf: url)
                let photoImage = UIImage(data: imageData)
                
                DispatchQueue.main.async {
                    self.image = photoImage
                }
            } catch let err {
                print(err.localizedDescription)
            }
        }
    }
}
