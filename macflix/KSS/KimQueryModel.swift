//
//  QueryModel.swift
//  ProjectDraw
//
//  Created by Kim_MAC on 2020/09/08.
//  Copyright © 2020 SSB. All rights reserved.
//

import Foundation
protocol KimQueryModelProtocol: class{
    func itemDownloaded(items:NSArray)
}
class KimQueryModel: NSObject{
    
    var delegate: KimQueryModelProtocol!
    let urlPath = CS_TOMCAT_ADDRESS + "beer_query_ios.jsp"
    
    func downloadItems(){
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil { // 에러코드가 없을 때 실행
                print("Failed to download data")
            }else{
                print("Data is downloaded")
                
                //parse JSON
                self.parseJSON(data!)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data){
        var jsonResult = NSArray()

        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        }catch let error as NSError{
            print(error)
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
        
    }
    
}//----
