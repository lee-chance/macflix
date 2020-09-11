//
//  UserPriorityQueryModel.swift
//  ProjectDraw
//
//  Created by SSB on 10/09/2020.
//  Copyright © 2020 SSB. All rights reserved.
//

import Foundation

protocol PriorityModelProtocol: class {
    func itemDownloaded(items: [String])
}

class UserPriorityQueryModel: NSObject{
    
    var delegate: PriorityModelProtocol!
    let urlPath = "http://localhost:8080/IOS/getPriorityList.jsp?seq=\(LOGGED_IN_SEQ)"
    
    func getPriorityList() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) {(data, respone, error) in
            if error != nil {
            } else {
                self.parseJSON2(data!)
            }
        }
        task.resume()
    }
    
    func parseJSON2(_ data: Data) {
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
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: resultList)
        })
        }
    
        
}
