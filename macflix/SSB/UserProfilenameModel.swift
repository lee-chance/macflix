//
//  UserProfilenameModel.swift
//  ProjectDraw
//
//  Created by SSB on 12/09/2020.
//  Copyright © 2020 SSB. All rights reserved.
//

import Foundation

protocol ProfilenameModelProtocol: class {
    func itemDownloaded(items: String)
}

class UserProfilenameModel: NSObject {
    
    var delegate: ProfilenameModelProtocol!
    var urlPath = URL_PATH + "IOS/getUserProfilename.jsp?seq=\(LOGGED_IN_SEQ)"
    
    func getProfilename() {
        
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
        jsonResult = jsonResult.replacingOccurrences(of: " ", with: "")
        
//        return Int(jsonResult) ?? 0
        LOGGED_IN_PROFILENAME = jsonResult
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: jsonResult)
        })
        
    }
    
}
