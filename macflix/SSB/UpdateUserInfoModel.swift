//
//  UpdateUserInfoModel.swift
//  ProjectDraw
//
//  Created by SSB on 12/09/2020.
//  Copyright © 2020 SSB. All rights reserved.
//

import Foundation

protocol CheckUserPassword: class {
    func checkPassword()
}

class UpdateUserInfoModel: NSObject {
    
    var delegate: CheckUserPassword!
    var urlPath = "http://localhost:8080/IOS/checkPassword.jsp"
    
    func checkPwd(user_password: String, completion: @escaping (Bool)->()) {
        let urlAdd = "?user_password=\(user_password)&seq=\(LOGGED_IN_SEQ)"
        urlPath += urlAdd
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) {(data, respone, error) in
            if error != nil {
                completion(false)
            } else {
                let result = self.parseJSON(data!)
                if result != "0" {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
        task.resume()
    }
        
    func parseJSON(_ data: Data) -> String {
            var jsonResult = String(data: data, encoding: .utf8)!
    //        do {
    //            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Bool
    //        } catch let error as NSError {
    //            print(error)
    //        }
            jsonResult = jsonResult.replacingOccurrences(of: "\r\n", with: "")
            jsonResult = jsonResult.replacingOccurrences(of: " ", with: "")
            jsonResult = jsonResult.replacingOccurrences(of: "\t", with: "")
            jsonResult = jsonResult.replacingOccurrences(of: "\n", with: "")

            return jsonResult
    //        DispatchQueue.main.async(execute: {() -> Void in
    //            self.delegate.checkLogin()
    //        })
            
        }
    
    
    
    func updateUserPassword(user_password: String, completion: @escaping (Bool)->()) {
        var urlPath = "http://localhost:8080/IOS/passwordUpdate_ios.jsp"
        let urlAdd = "?user_password=\(user_password)&seq=\(LOGGED_IN_SEQ)"
        urlPath += urlAdd
            // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
        task.resume()
    }
    
    func updateUserProfilename(user_profilename: String, completion: @escaping (Bool)->()) {
        var urlPath = "http://localhost:8080/IOS/profilenameUpdate_ios.jsp"
        let urlAdd = "?user_profilename=\(user_profilename)&seq=\(LOGGED_IN_SEQ)"
        urlPath += urlAdd
            // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
        task.resume()
    }
    
}
