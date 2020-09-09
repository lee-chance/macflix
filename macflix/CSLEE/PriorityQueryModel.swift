//
//  File.swift
//  KNNTest
//
//  Created by Changsu Lee on 2020/09/08.
//  Copyright © 2020 Changsu Lee. All rights reserved.
//

import Foundation

class PriorityQueryModel: NSObject {
    
    var delegate: CSQueryModelProtocol!
    var urlPath = CS_TOMCAT_ADDRESS + "selectPriorityBeer.jsp?"
    var urlPath2 = CS_TOMCAT_ADDRESS + "getPriorityList.jsp?"
    
    func getPriorityList(seq: Int, completion: @escaping ([String])->()) -> [String] {
        var result: [String] = []
        urlPath2 += "seq=\(seq)"
        // 한글 url encoding
        urlPath2 = urlPath2.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath2)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) {(data, respone, error) in
            if error != nil {
                completion([])
            } else {
                result = self.parseJSON2(data!)
                completion(result)
            }
        }
        task.resume()
        return result
    }
    
    func setItems(first: String, second: String, third: String, fourth: String, completion: @escaping (Bool)->()) {
        
        let urlAdd = "first=\(first)&second=\(second)&third=\(third)&fourth=\(fourth)"
        urlPath += urlAdd
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) {(data, respone, error) in
            if error != nil {
                completion(false)
            } else {
                self.parseJSON(data!)
                completion(true)
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
    
    func parseJSON2(_ data: Data) -> [String] {
        var jsonResult = String(data: data, encoding: .utf8)!
//        do {
//            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! String
//        } catch let error as NSError {
//            print(error)
//        }
        jsonResult = jsonResult.replacingOccurrences(of: "\r\n", with: "")
        let splitedList = jsonResult.components(separatedBy: ", ")
        var resultList: [String] = []
        for i in 0..<splitedList.count {
            resultList.append(splitedList[i])
        }
        return resultList
    }
    
}
