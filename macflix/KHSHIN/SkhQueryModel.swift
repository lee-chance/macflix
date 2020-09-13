//
//  SkhQueryModel.swift
//  finalBeerSearch
//
//  Created by 신경환 on 2020/09/11.
//  Copyright © 2020 신경환. All rights reserved.
//

import Foundation
protocol SkhQueryModelProtocol: class {
    func itemDownloaded(items: NSArray)
}

class SkhQueryModel: NSObject {
    var delegate: SkhQueryModelProtocol!
    var urlPath = "http://localhost:8080/test/beerSearch_query_ios.jsp"
    
    func downloadItems(aroma: String, appearance: String, palate: String, taste: String){
        let urlAdd = "?aroma=\(aroma)&appearance=\(appearance)&palate=\(palate)&taste=\(taste)"
        urlPath += urlAdd
        print(urlPath)
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil {
                print("Failed to download data")
            } else {
                print("Data is downloaded")
                self.parseJSON(data!)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data) {
        var jsonResult = NSArray()
        
        do {
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print(error)
        }
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
           
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let query = SkhDBModel()
            
            if let beerName = jsonElement["beername"] as? String,
               let beerStyle = jsonElement["style"] as? String,
               let beerAbv = jsonElement["abv"] as? String,
               let reviewAroma = jsonElement["aroma"] as? String,
               let reviewAppear = jsonElement["appear"] as? String,
               let reviewPalate = jsonElement["palate"] as? String,
               let reviewTaste = jsonElement["taste"] as? String,
               let reviewOverall = jsonElement["overall"] as? String {
                
                query.beerName = beerName
                query.beerStyle = beerStyle
                query.beerAbv = beerAbv
                query.reviewAroma = reviewAroma
                query.reviewAppear = reviewAppear
                query.reviewPalate = reviewPalate
                query.reviewTaste = reviewTaste
                query.reviewOverall = reviewOverall
            }
            locations.add(query)
            
        }
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
        })
    }
    
   
    
    
}
