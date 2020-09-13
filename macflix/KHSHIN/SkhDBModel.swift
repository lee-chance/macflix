//
//  SkhDBModel.swift
//  finalBeerSearch
//
//  Created by 신경환 on 2020/09/11.
//  Copyright © 2020 신경환. All rights reserved.
//

import Foundation
class SkhDBModel: NSObject {
    
    var beerName: String?
    var beerStyle: String?
    var beerAbv: String?
    var reviewAroma: String?
    var reviewAppear: String?
    var reviewPalate: String?
    var reviewTaste: String?
    var reviewOverall: String?
    
    override init() {
        
    }
    
    init(beerName: String, beerStyle: String, beerAbv: String, reviewAroma: String, reviewAppear: String, reviewPalate: String, reviewTaste: String, reviewOverall: String){
        self.beerName = beerName
        self.beerStyle = beerStyle
        self.beerAbv = beerAbv
        self.reviewAroma = reviewAroma
        self.reviewAppear = reviewAppear
        self.reviewPalate = reviewPalate
        self.reviewTaste = reviewTaste
        self.reviewOverall = reviewOverall
    }
}
