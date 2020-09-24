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
    var urlPath = URL_PATH + "CSJSP/getPriorityList.jsp"
    
    func getPriorityList() {
        let urlAdd = "?seq=\(LOGGED_IN_SEQ)"
        urlPath += urlAdd
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) {(data, respone, error) in
            if error != nil {
            } else {
                self.parseJSON(data!)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data) {
        var jsonResult = String(data: data, encoding: .utf8)!
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
