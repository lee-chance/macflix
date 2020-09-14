//
//  LoginModel.swift
//  KNNTest
//
//  Created by Changsu Lee on 2020/09/08.
//  Copyright © 2020 Changsu Lee. All rights reserved.
//

import Foundation

class LoginModel: NSObject {
    
    func actionLogin(email: String, password: String, completion: @escaping (Int)->()) {
        var urlPath = URL_PATH + "CSJSP/checkLogin.jsp?email=\(email)&password=\(password)"
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) {(data, respone, error) in
            
            if error != nil {
                completion(0)
            } else {
                let result = self.parseJSON(data!)
                if result != 0 {
                    completion(result)
                } else {
                    completion(0)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data) -> Int {
        var jsonResult = String(data: data, encoding: .utf8)!
        
        jsonResult = jsonResult.replacingOccurrences(of: "\r\n", with: "")
        jsonResult = jsonResult.replacingOccurrences(of: " ", with: "")
        
        return Int(jsonResult) ?? 0
    }
    
    func getUserData(seq: Int, completion: @escaping ([String]?) -> ()) {
        let urlPath = URL_PATH + "CSJSP/getUserData.jsp?seq=\(seq)"
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) {(data, respone, error) in
            if error != nil {
                completion(nil)
            } else {
                completion(self.parseUserData(data!))
            }
        }
        task.resume()
    }
    
    func parseUserData(_ data: Data) -> [String] {
        var jsonResult = String(data: data, encoding: .utf8)!
        
        jsonResult = jsonResult.replacingOccurrences(of: "\r\n", with: "")
        jsonResult = jsonResult.replacingOccurrences(of: " ", with: "")
        
        let splitedList = jsonResult.components(separatedBy: ",")
        var resultList: [String] = []
        for i in 0..<splitedList.count {
            resultList.append(splitedList[i])
        }
        
        return resultList
    }
    
}
