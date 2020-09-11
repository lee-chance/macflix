//
//  TableViewController.swift
//  ProjectDraw
//
//  Created by SSB on 07/09/2020.
//  Copyright © 2020 SSB. All rights reserved.
//

import UIKit

class SBTableViewController: UITableViewController, SBQueryModelProtocol {
    @IBOutlet var listTableView: UITableView!
    var beerArray: NSArray = NSArray()
    
    let heart : UIImage = UIImage(named:"heart.fill.png")!
    let no_heart : UIImage = UIImage(named:"heart.png")!

    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.rowHeight = 175
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let queryModel = SBQueryModel()
        queryModel.delegate = self
        queryModel.downloadItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let queryModel = SBQueryModel()
        queryModel.delegate = self
        queryModel.downloadItems()
    }
    
    func itemDownloaded(items: NSArray) {
        beerArray = items
        self.listTableView.reloadData()
    }
    
    
    @IBAction func btnLikeAction(_ sender: UIButton) {
        
        let contentView = sender.superview
        let cell = contentView?.superview as! SBTableViewCell
        let indexPath = tableView.indexPath(for: cell)
        
        let item: DBModelBeer = beerArray[indexPath![1]] as! DBModelBeer
        let preferenceModel = PreferenceModel()
        
        if item.heart == 0 {
            preferenceModel.insertItems(beer_id: item.beer_id) {isValid in
                DispatchQueue.main.async { () -> Void in
                    if isValid {
                        self.viewWillAppear(true)
                        self.heartAlert("좋아요에 추가했습니다.")}
                }
            }
        } else {
            preferenceModel.deleteItems(beer_id: item.beer_id) {isValid in
                DispatchQueue.main.async { () -> Void in
                    if isValid {
                        self.viewWillAppear(true)
                        self.heartAlert("좋아요에서 삭제했습니다.")}
                }
            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! SBTableViewCell

        let item: DBModelBeer = beerArray[indexPath.row] as! DBModelBeer
        cell.name.text = item.beer_name
        cell.style.text = item.beer_style
        cell.abv.text = "Abv \(item.beer_abv)"
        cell.review.text = "Aroma \(item.aroma!) Appearance \(item.appearance!) \nTaste \(item.taste!) Overall \(item.overall!)"
        cell.overall.text = item.overall
        
        if item.heart == 0 {
            cell.btnLike.setImage(no_heart, for: UIControl.State.normal)
        } else {
            cell.btnLike.setImage(heart, for: UIControl.State.normal)
        }
        
        return cell
    }

}
