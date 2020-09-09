//
//  DetailViewController.swift
//  ProjectDraw
//
//  Created by Kim_MAC on 2020/09/08.
//  Copyright © 2020 SSB. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var style: UILabel!
    @IBOutlet weak var abv: UILabel!
    @IBOutlet weak var overall: UILabel!
    @IBOutlet weak var review: UILabel!
    
//    var receiveImage : UIImage
    var receiveName = ""
    var receiveStyle = ""
    var receiveAbv = ""
    var receiveOverall = ""
    var receiveReview = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = receiveName
        style.text = receiveStyle
        abv.text = receiveAbv
        overall.text = receiveOverall
        review.text = receiveReview
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
