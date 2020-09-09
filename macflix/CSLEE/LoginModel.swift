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
    var urlPath = CS_TOMCAT_ADDRESS + "checkLogin.jsp"
    
    func actionLogin(email: String, password: String, completion: @escaping (Bool)->()) {
        let urlAdd = "?email=\(email)&password=\(password)"
        urlPath += urlAdd
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) {(data, respone, error) in
            
            if error != nil {
                completion(false)
            } else {
                if(self.parseJSON(data!)) {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
        task.resume()
        
    }
    
    func parseJSON(_ data: Data) -> Bool {
        var jsonResult = false
        do {
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Bool
        } catch let error as NSError {
            print(error)
        }
        
        return jsonResult
        
//        DispatchQueue.main.async(execute: {() -> Void in
//            self.delegate.checkLogin()
//        })
        
    }
    
}
