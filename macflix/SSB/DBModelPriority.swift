//
//  DBModelPriority.swift
//  ProjectDraw
//
//  Created by SSB on 10/09/2020.
//  Copyright © 2020 SSB. All rights reserved.
//

import Foundation

class DBModelPriority: NSObject {
    
    var user_email: String?
    var user_password: String?
    var user_profilename: String?
    var user_priority: String?

    override init() {
        
    }
    
    init(user_email: String, user_password: String, user_profilename: String, user_priority: String) {
        self.user_email = user_email
        self.user_password = user_password
        self.user_profilename = user_profilename
        self.user_priority = user_priority
    }
    
}
