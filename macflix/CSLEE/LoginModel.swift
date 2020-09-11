//
//  LoginModel.swift
//  KNNTest
//
//  Created by Changsu Lee on 2020/09/08.
//  Copyright © 2020 Changsu Lee. All rights reserved.
//

import Foundation

protocol LoginModelProtocol: class {
    func checkLogin()
}

class LoginModel: NSObject {
    
    var delegate: LoginModelProtocol!
    var urlPath = URL_PATH + "CSJSP/checkLogin.jsp"
    
    func actionLogin(email: String, password: String, completion: @escaping (Int)->()) {
        let urlAdd = "?email=\(email)&password=\(password)"
        urlPath += urlAdd
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
//        do {
//            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Bool
//        } catch let error as NSError {
//            print(error)
//        }
        jsonResult = jsonResult.replacingOccurrences(of: "\r\n", with: "")
        jsonResult = jsonResult.replacingOccurrences(of: " ", with: "")
        
        print(jsonResult)
        
        return Int(jsonResult) ?? 0
        
//        DispatchQueue.main.async(execute: {() -> Void in
//            self.delegate.checkLogin()
//        })
        
    }
    
}
