//
//  DBModel.swift
//  BeerSearch
//
//  Created by 신경환 on 2020/09/10.
//  Copyright © 2020 신경환. All rights reserved.
//

import Foundation

class DBModel: NSObject {
    
    var aroma: String?
    var apperance: String?
    var palate: String?
    var taste: String?
    var overall: String?
    
    override init() {
        
    }
    
    init(aroma: String, apperance: String, palate: String, taste: String, overall: String) {
        self.aroma = aroma
        self.apperance = apperance
        self.palate = palate
        self.taste = taste
        self.overall = overall
    }
}
