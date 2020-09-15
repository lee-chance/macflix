//
//  SearchTableViewController.swift
//  macflix
//
//  Created by Changsu Lee on 2020/09/14.
//  Copyright © 2020 Changsu Lee. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, SkhQueryModelProtocol {
    
    @IBOutlet var listTableView: UITableView!
    
    var heart : UIImage = #imageLiteral(resourceName: "beer_on.png")
    var no_heart: UIImage = #imageLiteral(resourceName: "beer_off.png")
    
    var feedItem: NSArray = NSArray()
    
    var keyword = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        listTableView.rowHeight = 165
        
        let searchModel = SearchModel()
        searchModel.delegate = self
        searchModel.searchKeyword(keyword: keyword) { (returnstr) in }
    }
    
    func itemDownloaded(items: NSArray) {
        feedItem = items
        self.listTableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feedItem.count
    }

    @IBAction func btnLikeAction(_ sender: UIButton) {
        let contentView = sender.superview
        let cell = contentView?.superview as! KimTableViewCell
        let indexPath = tableView.indexPath(for: cell)
        
        let item: KimDBModel = feedItem[indexPath![1]] as! KimDBModel
        let preferenceModel = PreferenceModel()
        
        // 창수 수정
        let beerId = Int(item.beerId!)!
        if LOGGED_IN_HEARTLIST.contains(beerId) {
            preferenceModel.deleteItems(beer_id: Int(item.beerId!)!) {isValid in
                DispatchQueue.main.async { () -> Void in
                    if isValid {
                        LOGGED_IN_HEARTLIST.remove(at: LOGGED_IN_HEARTLIST.firstIndex(of: beerId)!)
                        sender.setImage(self.no_heart, for: UIControl.State.normal)
                    }
                }
            }
        } else {
            preferenceModel.insertItems(beer_id: Int(item.beerId!)!) {isValid in
                DispatchQueue.main.async { () -> Void in
                    if isValid {
                        LOGGED_IN_HEARTLIST.append(beerId)
                        sender.setImage(self.heart, for: UIControl.State.normal)
                    }
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mySearchCell", for: indexPath) as! KimTableViewCell
        // Configure the cell...
        
        let item = feedItem[indexPath.row] as! KimDBModel // DB 모델타입으로 바꾸고, data 뽑아 쓸 수 있음
        cell.name.text = item.beerName
        cell.style.text = item.beerStyle
        cell.abv.text = item.beerAbv
        cell.review.text = "Feel :\(item.reviewFeel!) Look : \(item.reviewLook!) Smell : \(item.reviewSmell!) Taste : \(item.reviewTaste!)"
        cell.overall.text = item.reviewOverall
        
        let myURL = URL(string:"https://cdn.beeradvocate.com/im/beers/\(item.beerId!).jpg")
        let myRequest = URLRequest(url: myURL!)
        cell.webView.load(myRequest)
        
        if LOGGED_IN_HEARTLIST.contains(Int(item.beerId!)!) {
            cell.btnLike.setImage(heart, for: UIControl.State.normal)
        } else {
            cell.btnLike.setImage(no_heart, for: UIControl.State.normal)
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgSearch1"{
            let cell = sender as! UITableViewCell
            let indexPath = self.listTableView.indexPath(for : cell)
            let detailView = segue.destination as! KimDetailViewController
            let item = feedItem[indexPath!.row] as! KimDBModel // DB 모델타입으로 바꾸고, data 뽑아 쓸 수 있음
            
            detailView.receiveId = item.beerId!
            detailView.receiveName = item.beerName!
            detailView.receiveStyle = item.beerStyle!
            detailView.receiveAbv = item.beerAbv!
            detailView.receivebreweryName = item.brewery_name!
            detailView.receiveFeel = item.reviewFeel!
            detailView.receiveLook = item.reviewLook!
            detailView.receiveSmell = item.reviewSmell!
            detailView.receiveTaste = item.reviewTaste!
            detailView.receiveOverall = item.reviewOverall!
            detailView.receiveHeart = item.beerHeart
            detailView.receiveBrewery = item.breweryId!
            
        }
        
    }

}
