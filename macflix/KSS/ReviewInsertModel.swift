//
//  ReviewInsertModel.swift
//  macflix
//
//  Created by Kim_MAC on 2020/09/11.
//  Copyright © 2020 Changsu Lee. All rights reserved.
//

import Foundation
class ReviewInsertModel: NSObject {
    
    var urlPath = URL_PATH + "KSSJSP/insertReview.jsp"
    
    func actionReview(seq: String, beerid : String, profilename: String, aroma: String, appearance : String, palate : String, taste : String ,overall : String ,breweryId : String, completion: @escaping (Bool)->()) {
        
        let urlAdd = "?user_seq=\(seq)&beerid=\(beerid)&profilename=\(profilename)&aroma=\(aroma)&appearance=\(appearance)&palate=\(palate)&taste=\(taste)&overall=\(overall)&breweryId=\(breweryId)"
        urlPath += urlAdd
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) {(data, respone, error) in
            completion(error == nil)
        }
        task.resume()
    }
}
