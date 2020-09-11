//
//  DBModelBeer.swift
//  ProjectDraw
//
//  Created by SSB on 09/09/2020.
//  Copyright © 2020 SSB. All rights reserved.
//

import Foundation

class DBModelBeer: NSObject {
    //beer_id, beer_name, beer_style, beer_abv, clac, aroma, appearance, palate, taste, overall
    
    var beer_id: Int = 0
    var beer_name: String?
    var beer_style: String?
    var beer_abv: Double = 0.0
    var calc: String?
    var aroma: String?
    var appearance: String?
    var palate: String?
    var taste: String?
    var overall: String?
    var heart: Int = 0
    
    override init() {
        
    }
    
    init(beer_id: Int, beer_name: String, beer_style: String, beer_abv: Double, calc: String, aroma: String, appearance: String, palate: String, taste: String, overall: String, heart: Int) {
        self.beer_id = beer_id
        self.beer_name = beer_name
        self.beer_style = beer_style
        self.beer_abv = beer_abv
        self.calc = calc
        self.aroma = aroma
        self.appearance = appearance
        self.palate = palate
        self.taste = taste
        self.overall = overall
        self.heart = heart
    }
    
}
