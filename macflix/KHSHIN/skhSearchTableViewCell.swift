//
//  skhSearchTableViewCell.swift
//  finalBeerSearch
//
//  Created by 신경환 on 2020/09/11.
//  Copyright © 2020 신경환. All rights reserved.
//

import UIKit

class skhSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivBeerImage: UIImageView!
    @IBOutlet weak var lblBeerName: UILabel!
    @IBOutlet weak var lblBeerStyle: UILabel!
    @IBOutlet weak var lblAbv: UILabel!
    @IBOutlet weak var lblEvaluation: UILabel!
    @IBOutlet weak var lblOverall: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
