//
//  DBModel.swift
//  ProjectDraw
//
//  Created by Kim_MAC on 2020/09/08.
//  Copyright © 2020 SSB. All rights reserved.
//

import Foundation
class DBModel: NSObject{
    
    // Properties
    var beerName: String?
    var beerStyle: String?
    var beerAbv: String?
    var reviewSmell: String?
    var reviewFeel: String?
    var reviewLook: String?
    var reviewTaste: String?
    var reviewOverall: String?
    
    //Empty Constructor
    override init() {
        
    }
    
    // Constructor
    init(beerName: String, beerStyle:String, beerAbv:String,reviewSmell: String,reviewFeel: String,reviewLook: String,reviewTaste: String,reviewOverall: String) {
        self.beerName = beerName
        self.beerStyle = beerStyle
        self.beerAbv = beerAbv
        self.reviewSmell = reviewSmell
        self.reviewFeel = reviewFeel
        self.reviewLook = reviewLook
        self.reviewTaste = reviewTaste
        self.reviewOverall = reviewOverall
    }

    
}
