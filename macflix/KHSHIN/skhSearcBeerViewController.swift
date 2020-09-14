//
//  skhSearcBeerViewController.swift
//  finalBeerSearch
//
//  Created by 신경환 on 2020/09/11.
//  Copyright © 2020 신경환. All rights reserved.
//

import UIKit

class skhSearcBeerViewController: UIViewController {

    @IBOutlet var tfSerarch: UITextField!
    
    @IBOutlet var slFeel: UISlider!
    @IBOutlet var slLook: UISlider!
    @IBOutlet var slSmell: UISlider!
    @IBOutlet var slTaste: UISlider!
    
    @IBOutlet weak var lblFeel: UILabel!
    @IBOutlet weak var lblLook: UILabel!
    @IBOutlet weak var lblSmell: UILabel!
    @IBOutlet weak var lblTaste: UILabel!
    
    var feel2 = ""
    var look2 = ""
    var smell2 = ""
    var taste2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblFeel.text = String(format: "%.1f", floor(slFeel.value))
        lblLook.text = String(format: "%.1f", floor(slLook.value))
        lblSmell.text = String(format: "%.1f", floor(slSmell.value))
        lblTaste.text = String(format: "%.1f", floor(slTaste.value))
    }
    
    @IBAction func feelChanged(_ sender: UISlider) {
        let feel = Int(slFeel.value * 10)
        if (feel % 10 >= 0) && (feel % 10 < 5) {
            lblFeel.text = String(format: "%.1f", floor(slFeel.value))
            feel2 = String(format: "%.1f", floor(slFeel.value))
        } else if (feel % 10 >= 5) && (feel % 10 <= 9) {
            lblFeel.text = String(format: "%.1f", floor(slFeel.value) + 0.5)
            feel2 = String(format: "%.1f", floor(slFeel.value) + 0.5)
        }
    }
    
    @IBAction func lookChanged(_ sender: UISlider) {
        let look = Int(slLook.value * 10)
        if (look % 10 >= 0) && (look % 10 < 5) {
            lblLook.text = String(format: "%.1f", floor(slLook.value))
            look2 = String(format: "%.1f", floor(slLook.value))
        } else if (look % 10 >= 5) && (look % 10 <= 9) {
            lblLook.text = String(format: "%.1f", floor(slLook.value) + 0.5)
            look2 = String(format: "%.1f", floor(slLook.value) + 0.5)
        }
    }
    
    @IBAction func smellChanged(_ sender: UISlider) {
        let smell = Int(slSmell.value * 10)
        if (smell % 10 >= 0) && (smell % 10 < 5) {
            lblSmell.text = String(format: "%.1f", floor(slSmell.value))
            smell2 = String(format: "%.1f", floor(slSmell.value))
        } else if (smell % 10 >= 5) && (smell % 10 <= 9) {
            lblSmell.text = String(format: "%.1f", floor(slSmell.value) + 0.5)
            smell2 = String(format: "%.1f", floor(slSmell.value) + 0.5)
        }
    }
    
    @IBAction func tasteChanged(_ sender: UISlider) {
        let taste = Int(slTaste.value * 10)
        if (taste % 10 >= 0) && (taste % 10 < 5) {
            lblTaste.text = String(format: "%.1f", floor(slTaste.value))
            taste2 = String(format: "%.1f", floor(slTaste.value))
        } else if (taste % 10 >= 5) && (taste % 10 <= 9) {
            lblTaste.text = String(format: "%.1f", floor(slTaste.value) + 0.5)
            taste2 = String(format: "%.1f", floor(slTaste.value) + 0.5)
        }
    }
    
    @IBAction func btnSearch(_ sender: UIButton) {

        performSegue(withIdentifier: "searchBeer", sender: self)
    }
    
    @IBAction func actionKeyword(_ sender: UIButton) {
        performSegue(withIdentifier: "searchKeyword", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchBeer" {
            let searchDestination = segue.destination as! skhSearchTableViewController
                searchDestination.receivedPalate = feel2
                searchDestination.receivedApperance = look2
                searchDestination.receivedAroma = smell2
                searchDestination.receivedTaste = taste2
                
                searchDestination.receivedItems(smell2, look2, feel2, taste2)


        }
        if segue.identifier == "searchKeyword" {
            let searchDestination = segue.destination as! SearchTableViewController
            searchDestination.keyword = tfSerarch.text!
        }
    }
    
}
