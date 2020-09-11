//
//  UserPriorityQueryModel.swift
//  ProjectDraw
//
//  Created by SSB on 10/09/2020.
//  Copyright © 2020 SSB. All rights reserved.
//

import Foundation

protocol UserPriorityQueryModelProtocol: class {
    func itemDownloaded(items: NSArray)
}

// NSObject : Class Type, 선언을 마음대로 할 수 있다
// 그림도 포함되어 있는 클래스를 생성할 때 사용되는 Object(class)
// 모든 클래스 중 가장 상위 클래스
class UserPriorityQueryModel: NSObject{
    var delegate: UserPriorityQueryModelProtocol!
    let urlPath = URL_PATH + "IOS/priority_query_ios.jsp"
    
    func downloadItems() {
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
    
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil {
            } else {
                self.parseJSON(data!)
            }
        }
        task.resume()
        
    }
    
    func parseJSON(_ data: Data){
        // NSMutableArray()을 사용해야 할 때를 제외하고는 대부분 NSArray()를 사용한다
        // NSArray() : 데이터 추가 불가능
        // NSMutableArray() : 데이터 추가 가능
        var jsonResult = NSArray()
        
        do {
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        } catch let error as NSError {
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()

        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            let query = DBModelPriority()
            
            if let user_email = jsonElement["user_email"] as? String,
                let user_password = jsonElement["user_password"] as? String,
                let user_profilename = jsonElement["user_profilename"] as? String,
                let user_priority = jsonElement["user_priority"] as? String{
                query.user_email = user_email
                query.user_password = user_password
                query.user_profilename = user_profilename
                query.user_priority = user_priority

            }
            
            
            
            
            
            
            locations.add(query)
        }
            DispatchQueue.main.async(execute: {() -> Void in
                self.delegate.itemDownloaded(items: locations)
                
            })
        }
        
}
