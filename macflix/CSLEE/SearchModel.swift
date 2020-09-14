//
//  SearchModel.swift
//  macflix
//
//  Created by Changsu Lee on 2020/09/14.
//  Copyright © 2020 Changsu Lee. All rights reserved.
//

import Foundation

class SearchModel: NSObject {
    
    var delegate: SkhQueryModelProtocol!
    
    func searchKeyword(keyword: String, completion: @escaping (Bool)->()){
        var urlPath = URL_PATH + "CSJSP/selectSearchKeywords.jsp?keyword=\(keyword)"
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) {(data, respone, error) in
            if error != nil {
                completion(false)
            } else {
                completion(self.parseJSON(data!))
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data) -> Bool{
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print(error)
            return false
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        for i in 0..<jsonResult.count{
            jsonElement = jsonResult[i] as! NSDictionary // 제일 처음 중괄호 묶여있는 데이터 jsonResult[i]> 0번으로 들어와있고 > Dictionary로 바꿔주고
            
            let query = KimDBModel()
            
            if  let beerId = jsonElement["beer_id"] as? String,
                let beerName = jsonElement["beer_name"] as? String,
                let beerStyle = jsonElement["beer_style"] as? String,
                let beerAbv = jsonElement["beer_abv"] as? String,
                let reviewSmell = jsonElement["aroma"] as? String,
                let reviewLook = jsonElement["appearance"] as? String,
                let reviewFeel = jsonElement["palate"] as? String,
                let reviewTaste = jsonElement["taste"] as? String,
                let reviewOverall = jsonElement["overall"] as? String{

                query.beerId = beerId
                query.beerName = beerName
                query.beerStyle = beerStyle
                query.beerAbv = beerAbv
                query.reviewFeel = reviewFeel
                query.reviewLook = reviewLook
                query.reviewSmell = reviewSmell
                query.reviewTaste = reviewTaste
                query.reviewOverall = reviewOverall
            }
            
            // 배열에 넣어줌
            locations.add(query)
        }
        
        // 프로토콜로 전달
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
        })

        return true
    
    }
    
}
