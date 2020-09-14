//
//  skhSearchTableViewController.swift
//  finalBeerSearch
//
//  Created by 신경환 on 2020/09/11.
//  Copyright © 2020 신경환. All rights reserved.
//

import UIKit

class skhSearchTableViewController: UITableViewController, SkhQueryModelProtocol {
    
    var heart : UIImage = #imageLiteral(resourceName: "beer_on.png")
    var no_heart: UIImage = #imageLiteral(resourceName: "beer_off.png")
    
    @IBOutlet var listTableView: UITableView!
    var feedItem: NSArray = NSArray()
    var receivedAroma = ""
    var receivedApperance = ""
    var receivedPalate = ""
    var receivedTaste = ""
    var receivedSerarch = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let queryModel = SkhQueryModel()
        //receivedTaste = re
        queryModel.delegate = self
        queryModel.downloadItems(aroma: receivedAroma, appearance: receivedApperance, palate: receivedPalate, taste: receivedTaste)
        
        listTableView.rowHeight = 165
    }

    // MARK: - Table view data source
    
    func itemDownloaded(items: NSArray) {
        feedItem = items
        self.listTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let queryModel = SkhQueryModel()
        queryModel.delegate = self
        queryModel.downloadItems(aroma: receivedAroma, appearance: receivedApperance, palate: receivedPalate, taste: receivedTaste)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feedItem.count
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
    
    func receivedItems(_ aroma:String, _ apperance:String, _ palate:String, _ taste:String) {
        receivedAroma = aroma
        receivedApperance = apperance
        receivedPalate = palate
        receivedTaste = taste
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
