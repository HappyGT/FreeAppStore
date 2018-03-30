//
//  FinanceApp.swift
//  FreeAppStore
//
//  Created by LeeYoung Woon on 2018. 3. 27..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import Foundation

struct FinanceApp: Decodable {
    var trackName: String?
    var trackId: Int?
    var artistName: String?
    var artworkUrl100: String?
    
    var fileSizeBytes: String?

    var currentVersionReleaseDate: String?
    var releaseNotes: String?
    var screenshotUrls: [String]?
    
    var minimumOsVersion: String?
    var version: String?
    
    var description: String?
    var formattedPrice: String?
    
    var trackContentRating: String?
    var userRatingCount: Int?
    var averageUserRating: Float?
    
    var genres: [String]?
    var languageCodesISO2A: [String]?
    
    
}
