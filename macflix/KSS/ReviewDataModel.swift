//
//  ReviewDataModel.swift
//  macflix
//
//  Created by Kim_MAC on 2020/09/12.
//  Copyright © 2020 Changsu Lee. All rights reserved.
//

import Foundation
class ReviewDataModel: NSObject{

    func getReviewData(seq: Int, beerid: Int, completion: @escaping ([String])->()) -> [String] {
    var urlPath = URL_PATH + "KSSJSP/ReviewData.jsp?"
    var result: [String] = []
    urlPath += "user_seq=\(seq)&beerid=\(beerid)"
    // 한글 url encoding
    urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    
    let url: URL = URL(string: urlPath)!
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


func parseJSON2(_ data: Data) -> [String] {
    var jsonResult = String(data: data, encoding: .utf8)!
    
    jsonResult = jsonResult.replacingOccurrences(of: "\r\n", with: "")
    let splitedList = jsonResult.components(separatedBy: ",")
    var resultList: [String] = []
    for i in 0..<splitedList.count {
        resultList.append(splitedList[i])
    }
    return resultList
}
}
