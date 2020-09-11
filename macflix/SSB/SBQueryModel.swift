//
//  QueryModel.swift
//  ProjectDraw
//
//  Created by SSB on 09/09/2020.
//  Copyright © 2020 SSB. All rights reserved.
//

import Foundation

protocol SBQueryModelProtocol: class {
    func itemDownloaded(items: NSArray)
}

// NSObject : Class Type, 선언을 마음대로 할 수 있다
// 그림도 포함되어 있는 클래스를 생성할 때 사용되는 Object(class)
// 모든 클래스 중 가장 상위 클래스
class SBQueryModel: NSObject{
    var delegate: SBQueryModelProtocol!
    let urlPath = URL_PATH + "IOS/beer_query_ios.jsp"
    
    func downloadItems() {
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
    
    func parseJSON(_ data: Data){
        // NSMutableArray()을 사용해야 할 때를 제외하고는 대부분 NSArray()를 사용한다
        // NSArray() : 데이터 추가 불가능
        // NSMutableArray() : 데이터 추가 가능
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
            let query = DBModelBeer()
            
            if let beer_id = jsonElement["beer_id"] as? String,
                let beer_name = jsonElement["beer_name"] as? String,
                let beer_style = jsonElement["beer_style"] as? String,
                let beer_abv = jsonElement["beer_abv"] as? String,
                let calc = jsonElement["calc"] as? String,
                let aroma = jsonElement["aroma"] as? String,
                let appearance = jsonElement["appearance"] as? String,
                let palate = jsonElement["palate"] as? String,
                let taste = jsonElement["taste"] as? String,
                let overall = jsonElement["overall"] as? String,
                let heart = jsonElement["heart"] as? String {
                query.beer_id = Int(beer_id)!
                query.beer_name = beer_name
                query.beer_style = beer_style
                query.beer_abv = Double(beer_abv)!
                query.calc = calc
                query.aroma = aroma
                query.appearance = appearance
                query.palate = palate
                query.taste = taste
                query.overall = overall
                query.heart = Int(heart)!
                
            }
            
            locations.add(query)
        }
            DispatchQueue.main.async(execute: {() -> Void in
                self.delegate.itemDownloaded(items: locations)
                
            })
        }
        
}
    
