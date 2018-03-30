//
//  TopFreeApplication.swift
//  FreeAppStore
//
//  Created by LeeYoung Woon on 2018. 3. 27..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

struct TopFreeApp {
    var imageUrl: String?
    var name: String?
    var category: String?
    var id: String?
    
    init(dictionary: [String: Any]) {
        if let imageArray = dictionary[JSONKey.Image.rawValue] as? [Any] {
            if let image = imageArray.first as? [String: Any] {
                self.imageUrl = image[JSONKey.Label.rawValue] as? String
            }
        }

        if let nameDictionary = dictionary[JSONKey.Name.rawValue] as? [String: Any] {
            self.name = nameDictionary[JSONKey.Label.rawValue] as? String
        }
        
        if let categoryDictionary = dictionary[JSONKey.Category.rawValue] as? [String: Any] {
            if let attriDictionary = categoryDictionary[JSONKey.Attributes.rawValue] as? [String: Any] {
                self.category = attriDictionary[JSONKey.Label.rawValue] as? String
            }
        }
        
        if let idDictionary = dictionary[JSONKey.Id.rawValue] as? [String: Any] {
            if let attriDictionary = idDictionary[JSONKey.Attributes.rawValue] as? [String: Any] {
                self.id = attriDictionary[JSONKey.IdValue.rawValue] as? String
            }
        }
    }
}
