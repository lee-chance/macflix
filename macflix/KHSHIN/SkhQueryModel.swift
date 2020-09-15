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
    var urlPath = URL_PATH + "SKHJSP/beerSearch_query_ios.jsp"
    
    func downloadItems(aroma: String, appearance: String, palate: String, taste: String){
        let urlAdd = "?aroma=\(aroma)&appearance=\(appearance)&palate=\(palate)&taste=\(taste)"
        urlPath += urlAdd
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil {
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
        }catch let error as NSError{
            print(error)
        }
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
           
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let query = KimDBModel()
            
            if  let beerId = jsonElement["beer_id"] as? String,
                let beerName = jsonElement["beer_name"] as? String,
                let beerStyle = jsonElement["beer_style"] as? String,
                let beerAbv = jsonElement["beer_abv"] as? String,
                let reviewSmell = jsonElement["aroma"] as? String,
                let reviewLook = jsonElement["appearance"] as? String,
                let reviewFeel = jsonElement["palate"] as? String,
                let reviewTaste = jsonElement["taste"] as? String,
                let reviewOverall = jsonElement["overall"] as? String,
                let breweryId = jsonElement["brewery_id"] as? String,
                let brewery_name = jsonElement["brewery_name"] as? String{

                query.beerId = beerId
                query.beerName = beerName
                query.beerStyle = beerStyle
                query.beerAbv = beerAbv
                query.reviewFeel = reviewFeel
                query.reviewLook = reviewLook
                query.reviewSmell = reviewSmell
                query.reviewTaste = reviewTaste
                query.reviewOverall = reviewOverall
                query.breweryId = breweryId
                query.brewery_name = brewery_name
            }
            locations.add(query)
            
        }
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
        })
    }
    
   
    
    
}
