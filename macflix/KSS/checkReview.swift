//
//  checkReview.swift
//  macflix
//
//  Created by Kim_MAC on 2020/09/11.
//  Copyright © 2020 Changsu Lee. All rights reserved.
//

import Foundation
protocol CheckReviewModelProtocol: class {
    func checkReview()
}

class CheckReviewModel: NSObject {
    
    var delegate: CheckReviewModelProtocol!
    var urlPath = URL_PATH + "KSSJSP/checkReview.jsp"
    
    func actioncheckReview(seq: String, beerid: String, completion: @escaping (Int)->()) {
        let urlAdd = "?user_seq=\(seq)&beerid=\(beerid)"
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
        
        return Int(jsonResult) ?? 0
        
//        DispatchQueue.main.async(execute: {() -> Void in
//            self.delegate.checkLogin()
//        })
        
    }
    
}
