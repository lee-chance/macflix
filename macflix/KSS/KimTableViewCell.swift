//
//  TableViewCell.swift
//  ProjectDraw
//
//  Created by SSB on 07/09/2020.
//  Copyright © 2020 SSB. All rights reserved.
//

import UIKit
import WebKit

class KimTableViewCell: UITableViewCell {


    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var style: UILabel!
    @IBOutlet weak var abv: UILabel!
    @IBOutlet weak var overall: UILabel!
    @IBOutlet weak var review: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
