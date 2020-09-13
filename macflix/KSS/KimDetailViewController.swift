//
//  DetailViewController.swift
//  ProjectDraw
//
//  Created by Kim_MAC on 2020/09/08.
//  Copyright © 2020 SSB. All rights reserved.
//

import UIKit

class KimDetailViewController: UIViewController{
    
    
    var heart : UIImage = #imageLiteral(resourceName: "beer_on.png")
    var no_heart: UIImage = #imageLiteral(resourceName: "beer_off.png")
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var style: UILabel!
    @IBOutlet weak var abv: UILabel!
    @IBOutlet weak var overall: UILabel!
    @IBOutlet weak var review: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    
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
    var receiveId = ""
    var checkReview = 0
    var receiveHeart = 0
    var feedItem : NSArray = NSArray()
    
    var btnState: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewCheck()
        name.text = receiveName
        style.text = receiveStyle
        abv.text = receiveAbv
        overall.text = receiveOverall
        review.text = receiveReview
        
        if receiveHeart != 0 {
            btnLike.setImage(heart, for: UIControl.State.normal)
        } else {
            btnLike.setImage(no_heart, for: UIControl.State.normal)
        }
        
        btnState = receiveHeart
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        let preferenceModel = PreferenceModel()
        let alertService = AlertService()
        
        if receiveHeart == btnState {
            
        } else {
            if btnState != 0 {
                preferenceModel.insertItems(beer_id: Int(receiveId)!) {isValid in
                    DispatchQueue.main.async { () -> Void in
                        if !isValid {
                            self.present(alertService.mAlert(alertTitle: "Error", alertMessage: "An error has occurred.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
                        }
                    }
                }
            } else {
                preferenceModel.deleteItems(beer_id: Int(receiveId)!) {isValid in
                    DispatchQueue.main.async { () -> Void in
                        if !isValid {
                            self.present(alertService.mAlert(alertTitle: "Error", alertMessage: "An error has occurred.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
                        }
                    }
                }
            }

            
        }
    }
    
    @IBAction func btnLikeAction(_ sender: UIButton) {
        
        if btnState == 0 {
            btnLike.setImage(heart, for: UIControl.State.normal)
            btnState = 1
        } else {
            btnLike.setImage(no_heart, for: UIControl.State.normal)
            btnState = 0
        }
    }
    
    @IBAction func beerReview(_ sender: UIButton) {
        let alertService = AlertService()
        if checkReview != 0{
            let feel =  Double(feelNum.text!)
            let smell = Double(smellNum.text!)
            let look = Double(lookNum.text!)
            let taste = Double(tasteNum.text!)
            let ovarall  = String(format: "%.1f",(feel!+look!+smell!+taste!)/4)
            let updateReview = ReviewUpdateModel()
            updateReview.actionReviewUpdate(seq: String(checkReview), aroma: self.smellNum.text!, appearance: self.feelNum.text!, palate: self.lookNum.text!, taste: self.tasteNum.text!, overall: ovarall){ isValid in
                DispatchQueue.main.async { () -> Void in
                    if isValid {
                        self.present(alertService.mAlert(alertTitle: "ReviewUpdate!", alertMessage: "ReviewUpdate successfully.", actionTitle: "Ok", handler: {Void in
                            self.navigationController?.popViewController(animated: true)
                        }), animated: true, completion: nil)
                    } else {
                        self.present(alertService.mAlert(alertTitle: "Error", alertMessage: "An error has occurred.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
                    }
                }
            }
        }else{
            let feel =  Double(feelNum.text!)
            let smell = Double(smellNum.text!)
            let look = Double(lookNum.text!)
            let taste = Double(tasteNum.text!)
            let ovarall  = String(format: "%.1f",(feel!+look!+smell!+taste!)/4)
            let reviewInsert = ReviewInsertModel()
            reviewInsert.actionReview(seq: String(LOGGED_IN_SEQ),beerid: receiveId, profilename: LOGGED_IN_PROFILENAME, aroma: self.smellNum.text!, appearance: self.feelNum.text!, palate: self.lookNum.text!, taste: self.tasteNum.text!, overall: ovarall){ isValid in
                DispatchQueue.main.async { () -> Void in
                    if isValid {
                        self.present(alertService.mAlert(alertTitle: "ReviewInsert!", alertMessage: "ReviewInsert successfully.", actionTitle: "Ok", handler: {Void in
                            self.navigationController?.popViewController(animated: true)
                        }), animated: true, completion: nil)
                    } else {
                        self.present(alertService.mAlert(alertTitle: "Error", alertMessage: "An error has occurred.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
                    }
                }
            }
        }
    }
    func reviewCheck() {
        let checkReviewModel = CheckReviewModel()
        checkReviewModel.actioncheckReview(seq: String(LOGGED_IN_SEQ), beerid: receiveId) { resultSeq in
            DispatchQueue.main.async { () -> Void in
                if resultSeq != 0 {
                    self.checkReview = resultSeq
                    print(resultSeq)
                    let reviewdata = ReviewDataModel()
                    _ = reviewdata.getReviewData(seq: LOGGED_IN_SEQ, beerid: Int(self.receiveId)!){ resultlist in
                        DispatchQueue.main.async { () -> Void in
                            self.smellNum.text = resultlist[0]
                            self.sdSmell.value = NSString(string: resultlist[0]).floatValue
                            self.feelNum.text = resultlist[1]
                            self.sdFell.value = NSString(string: resultlist[1]).floatValue
                            self.lookNum.text = resultlist[2]
                            self.sdLook.value = NSString(string: resultlist[2]).floatValue
                            self.tasteNum.text = resultlist[3]
                            self.sdTaste.value = NSString(string: resultlist[3]).floatValue
                            print(resultlist[0])
                        }
                        
                    }
                } else {
                    self.checkReview = resultSeq
                    print(resultSeq)
                }
            }
        }
    }
    @IBAction func feelSd(_ sender: UISlider) {
        if Int(sdFell.value*10) % 10 >= 0 && Int(sdFell.value*10) % 10 < 5{
            feelNum.text = String(format: "%.1f",sdFell.value)
            print(feelNum.text!)
        }
    }
    @IBAction func lookSd(_ sender: UISlider) {
        if Int(sdLook.value*10) % 10 >= 0 && Int(sdLook.value*10) % 10 < 5{
            lookNum.text = String(format: "%.1f",sdLook.value)
            print(lookNum.text!)
        }
    }
    @IBAction func smellSd(_ sender: UISlider) {
        if Int(sdSmell.value*10) % 10 >= 0 && Int(sdSmell.value*10) % 10 < 5{
            smellNum.text = String(format: "%.1f",sdSmell.value)
            print(smellNum.text!)
        }
    }
    @IBAction func tasteSd(_ sender: UISlider) {
        if Int(sdTaste.value*10) % 10 >= 0 && Int(sdTaste.value*10) % 10 < 5{
            tasteNum.text = String(format: "%.1f",sdTaste.value)
            print(tasteNum.text!)
        }
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
