//
//  SignupModel.swift
//  KNNTest
//
//  Created by Changsu Lee on 2020/09/08.
//  Copyright © 2020 Changsu Lee. All rights reserved.
//

import Foundation

class SignupModel: NSObject {
    
    var urlPath = CS_TOMCAT_ADDRESS + "insertAccount.jsp"
    
    func actionSignup(email: String, password: String, nickname: String, priority: [String]) -> Bool {
        var result: Bool = true
        let strPriority = priority.joined(separator: ", ")
        let urlAdd = "?email=\(email)&password=\(password)&nickname=\(nickname)&priority=\(strPriority)"
        urlPath += urlAdd
        print(urlPath)
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) {(data, respone, error) in
            result = (error == nil)
        }
        task.resume()
        
        return result
    }
}
