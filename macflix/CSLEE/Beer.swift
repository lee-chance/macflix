//
//  Beer.swift
//  KNNTest
//
//  Created by Changsu Lee on 2020/09/06.
//  Copyright © 2020 Changsu Lee. All rights reserved.
//

import Foundation

class Beer: NSObject {
    
    var beerid: Int?
    var beer_name, beer_style, beer_abv: String?
    
    override init() {}
    
    init(beerid: Int, beer_name: String, beer_style: String, beer_abv: String) {
        self.beerid = beerid
        self.beer_name = beer_name
        self.beer_style = beer_style
        self.beer_abv = beer_abv
    }
    
}
