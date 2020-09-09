//
//  QueryModel.swift
//  KNNTest
//
//  Created by Changsu Lee on 2020/09/05.
//  Copyright © 2020 Changsu Lee. All rights reserved.
//

import Foundation

protocol QueryModelProtocol: class {
    func itemDownloaded(items: NSArray)
}

class QueryModel: NSObject {
    
    var delegate: QueryModelProtocol!
    let urlPath = "http://localhost:8080/Test/selectSampleBeer.jsp"
    
    func downloadItems() {
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil {
                print("Failed to download data")
            } else {
                self.parseJSON(data!)
            }
        }
        
        task.resume()
    }
    
    func parseJSON(_ data: Data) {
        var jsonResult = NSArray()
        do {
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        } catch let error as NSError {
            print(error)
        }
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            let query = Beer()
            
            if let beerid = jsonElement["beerid"] as? String,
                let beer_name = jsonElement["beer_name"] as? String,
                let beer_style = jsonElement["beer_style"] as? String,
                let beer_abv = jsonElement["beer_abv"] as? String {
                
                query.beerid = Int(beerid)
                query.beer_name = beer_name
                query.beer_style = beer_style
                query.beer_abv = beer_abv
            }
            
            locations.add(query)
        }
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
        })
        
    }
    
}
