//
//  LikeTableViewController.swift
//  ProjectDraw
//
//  Created by SSB on 08/09/2020.
//  Copyright © 2020 SSB. All rights reserved.
//

import UIKit

class LikeTableViewController: UITableViewController, PreferenceQueryModelProtocol {

    @IBOutlet var listTableView: UITableView!
        var beerArray: NSArray = NSArray()
        
        let heart : UIImage = #imageLiteral(resourceName: "beer_on.png")
        let no_heart : UIImage = #imageLiteral(resourceName: "beer_off.png")

        override func viewDidLoad() {
            super.viewDidLoad()
            listTableView.rowHeight = 175
            
            self.listTableView.delegate = self
            self.listTableView.dataSource = self
        }
        
        override func viewWillAppear(_ animated: Bool) {
            let queryModel = PreferenceQueryModel()
            queryModel.delegate = self
            queryModel.downloadItems()
        }
        
        func itemDownloaded(items: NSArray) {
            beerArray = items
            self.listTableView.reloadData()
        }
        
        
        @IBAction func btnLikeAction(_ sender: UIButton) {
            let contentView = sender.superview
            let cell = contentView?.superview as! LikeTableViewCell
            let indexPath = tableView.indexPath(for: cell)
            
            let item: KimDBModel = beerArray[indexPath![1]] as! KimDBModel
            let preferenceModel = PreferenceModel()
            
            let beerId = Int(item.beerId!)!
            
            if LOGGED_IN_HEARTLIST.contains(beerId) {
                preferenceModel.deleteItems(beer_id: beerId) {isValid in
                    DispatchQueue.main.async { () -> Void in
                        if isValid {
                            LOGGED_IN_HEARTLIST.remove(at: LOGGED_IN_HEARTLIST.firstIndex(of: beerId)!)
                            self.viewWillAppear(true)
                        }
                    }
                }
            }
            
//            if item.beerHeart == 1 {
//                preferenceModel.deleteItems(beer_id: Int(item.beerId!)!) {isValid in
//                    DispatchQueue.main.async { () -> Void in
//                        if isValid {
//                            self.viewWillAppear(true)
//                            self.heartAlert("좋아요에서 삭제했습니다.")}
//                    }
//                }
//            }

        }
        
        
        func heartAlert(_ msg: String) {
            let alert = UIAlertController(title: nil, message: msg, preferredStyle: UIAlertController.Style.alert)
            let cancelAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
        
        

        // MARK: - Table view data source
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return beerArray.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myLikeCell", for: indexPath) as! LikeTableViewCell

            let item: KimDBModel = beerArray[indexPath.row] as! KimDBModel // DB 모델타입으로 바꾸고, data 뽑아 쓸 수 있음
            cell.name.text = item.beerName
            cell.style.text = item.beerStyle
            cell.abv.text = item.beerAbv
            cell.review.text = "Feel :\(item.reviewFeel!) Look : \(item.reviewLook!) Smell : \(item.reviewSmell!) Taste : \(item.reviewTaste!)"
            cell.overall.text = item.reviewOverall
            
            if LOGGED_IN_HEARTLIST.contains(Int(item.beerId!)!) {
                cell.btnLike.setImage(heart, for: UIControl.State.normal)
            } else {
                cell.btnLike.setImage(no_heart, for: UIControl.State.normal)
            }
                
//            if item.beerHeart == 0 {
//                cell.btnLike.setImage(no_heart, for: UIControl.State.normal)
//            } else {
//                cell.btnLike.setImage(heart, for: UIControl.State.normal)
//            }
                
            return cell
        }

    
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "sgLikeCell"{
                let cell = sender as! UITableViewCell
                let indexPath = self.listTableView.indexPath(for : cell)
                let detailView = segue.destination as! KimDetailViewController
                let item: KimDBModel = beerArray[indexPath!.row] as! KimDBModel // DB 모델타입으로 바꾸고, data 뽑아 쓸 수 있음
                detailView.receiveId = item.beerId!
                detailView.receiveName = item.beerName!
                detailView.receiveStyle = item.beerStyle!
                detailView.receiveAbv = "Abv : \(item.beerAbv!)"
                detailView.receiveReview = "Feel :\(item.reviewFeel!) Look : \(item.reviewLook!) Smell : \(item.reviewSmell!) Taste : \(item.reviewTaste!)"
                detailView.receiveOverall = item.reviewOverall!
                detailView.receiveHeart = item.beerHeart
            }

        }
    

}

