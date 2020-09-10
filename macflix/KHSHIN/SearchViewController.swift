//
//  SearchViewController.swift
//  BeerSearch
//
//  Created by 신경환 on 2020/09/10.
//  Copyright © 2020 신경환. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    

    @IBOutlet var tfSerarch: UITextField!
    @IBOutlet var lblFeel: UILabel!
    @IBOutlet var lblLook: UILabel!
    @IBOutlet var lblSmell: UILabel!
    @IBOutlet var lblTaste: UILabel!
    
    @IBOutlet var slFeel: UISlider!
    @IBOutlet var slLook: UISlider!
    @IBOutlet var slSmell: UISlider!
    @IBOutlet var slTaste: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func feelChanged(_ sender: UISlider) {
        let feel = Int(slFeel.value*10)
        if (feel % 10 >= 0) && (feel % 10 < 5) {
            lblFeel.text = String(format: "%.1f", floor(slFeel.value))
        } else if (feel % 10 >= 5) && (feel % 10 <= 9) {
            lblFeel.text = String(format: "%.1f", floor(slFeel.value) + 0.5)
        }
    }
    
    @IBAction func lookChanged(_ sender: UISlider) {
        let look = Int(slLook.value*10)
        if (look % 10 >= 0) && (look % 10 < 5) {
            lblLook.text = String(format: "%.1f", floor(slLook.value))
        } else if (look % 10 >= 5) && (look % 10 <= 9) {
            lblLook.text = String(format: "%.1f", floor(slLook.value) + 0.5)
        }
    }
    
    @IBAction func smellChanged(_ sender: UISlider) {
        let smell = Int(slSmell.value*10)
        if (smell % 10 >= 0) && (smell % 10 < 5) {
            lblSmell.text = String(format: "%.1f", floor(slSmell.value))
        } else if (smell % 10 >= 5) && (smell % 10 <= 9) {
            lblSmell.text = String(format: "%.1f", floor(slSmell.value) + 0.5)
        }
    }
    
    @IBAction func tasteChanged(_ sender: UISlider) {
        let taste = Int(slTaste.value*10)
        if (taste % 10 >= 0) && (taste % 10 < 5) {
            lblTaste.text = String(format: "%.1f", floor(slTaste.value))
        } else if (taste % 10 >= 5) && (taste % 10 <= 9) {
            lblTaste.text = String(format: "%.1f", floor(slTaste.value) + 0.5)
        }
    }
    
}
