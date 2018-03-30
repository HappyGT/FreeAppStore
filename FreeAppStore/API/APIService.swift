//
//  APIService.swift
//  FreeAppStore
//
//  Created by LeeYoung Woon on 2018. 3. 27..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

typealias TopFreeAppsResponse = ([TopFreeApp]) -> ()
typealias FinanceAppsResponse = ([FinanceApp]) -> ()

struct APIService {
    static let shared = APIService()
    
    static let session = URLSession(configuration: .default)
    static var dataTask: URLSessionDataTask?
    
    func fetchTopFreeApps(completion: @escaping TopFreeAppsResponse) {
        let topFreeAppsJsonUrl = "https://itunes.apple.com/kr/rss/topfreeapplications/limit=100/genre=6015/json"
        guard let url = URL(string: topFreeAppsJsonUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            guard let jsonData = data else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] else { return }
                
                guard let feedJson = json["feed"] as? [String: Any] else { return }
                guard let entryJson = feedJson["entry"] as? [Any] else { return }
                
                var freeApps = [TopFreeApp]()
                entryJson.forEach({ (entryValue) in
                    guard let entryDictionary = entryValue as? [String: Any] else { return }
                    let freeApp = TopFreeApp(dictionary: entryDictionary)
                    
                    freeApps.append(freeApp)
                })
                
                DispatchQueue.main.async {
                    completion(freeApps)
                }
            } catch let err {
                print("Failed fetch top free applications: ", err.localizedDescription)
            }
        }.resume()
    }
    
    func fetchFinanceApps(appId: String, completion: @escaping FinanceAppsResponse) {
        
        APIService.dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: "https://itunes.apple.com/lookup") {
            urlComponents.query = "country=kr&entity=software&genreId=6015&limit=50&id=\(appId)"
            
            guard let url = urlComponents.url else { return }
            print(url.absoluteString)
            
            APIService.dataTask = APIService.session.dataTask(with: url, completionHandler: { (data, resp, err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                
                guard let jsonData = data else { return }
                do {
                    let lookupResult = try JSONDecoder().decode(LookupResult.self, from: jsonData)
                    completion(lookupResult.results)
                } catch let err {
                    print("Failed fetch finance application detail: ", err.localizedDescription)
                }
            })
            
            APIService.dataTask?.resume()
        }
    }
    
    struct LookupResult: Decodable {
        let resultCount: Int?
        let results: [FinanceApp]
    }
}



