//
//  DetailViewController.swift
//  ProjectDraw
//
//  Created by Kim_MAC on 2020/09/08.
//  Copyright © 2020 SSB. All rights reserved.
//

import UIKit

class KimDetailViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var style: UILabel!
    @IBOutlet weak var abv: UILabel!
    @IBOutlet weak var overall: UILabel!
    @IBOutlet weak var review: UILabel!
    
    @IBOutlet weak var feelNum: UILabel!
    @IBOutlet weak var lookNum: UILabel!
    @IBOutlet weak var smellNum: UILabel!
    @IBOutlet weak var tasteNum: UILabel!
    
    @IBOutlet weak var sdFell: UISlider!
    @IBOutlet weak var sdLook: UISlider!
    @IBOutlet weak var sdSmell: UISlider!
    @IBOutlet weak var sdTaste: UISlider!
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
    @IBAction func beerReview(_ sender: UIButton) {
    }
    @IBAction func feelSd(_ sender: UISlider) {
        
        if Int(sdFell.value*10) % 10 >= 0 && Int(sdFell.value*10) % 10 < 5{
            feelNum.text = String(format: "%.1f",sdFell.value*10)
            print(feelNum.text!)
        }
    }
    @IBAction func lookSd(_ sender: UISlider) {
    }
    @IBAction func smellSd(_ sender: UISlider) {
    }
    @IBAction func tasteSd(_ sender: UISlider) {
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
