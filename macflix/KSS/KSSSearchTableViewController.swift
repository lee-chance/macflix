//
//  SearchTableViewController.swift
//  ProjectDraw
//
//  Created by SSB on 07/09/2020.
//  Copyright © 2020 SSB. All rights reserved.
//

import UIKit

class KSSSearchTableViewController: UITableViewController, KimQueryModelProtocol {
    
    var heart : UIImage = #imageLiteral(resourceName: "beer_on.png")
    var no_heart: UIImage = #imageLiteral(resourceName: "beer_off.png")
    
    @IBOutlet var listTableView: UITableView!
    var feedItem: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 디비 연결
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        // 백버튼 지우기
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: true)
        
        listTableView.rowHeight = 164
    }
    func itemDownloaded(items: NSArray) {
        feedItem = items
        self.listTableView.reloadData()
    }
    
    // 수빈 추가
    @IBAction func btnLikeAction(_ sender: UIButton) {
        let contentView = sender.superview
        let cell = contentView?.superview as! KimTableViewCell
        let indexPath = tableView.indexPath(for: cell)
        
        let item: KimDBModel = feedItem[indexPath![1]] as! KimDBModel
        let preferenceModel = PreferenceModel()
        
        print(item.beerHeart)
        
        if item.beerHeart == 0 {
            preferenceModel.insertItems(beer_id: Int(item.beerId!)!) {isValid in
                DispatchQueue.main.async { () -> Void in
                    if isValid {
                        self.viewWillAppear(true)
                        self.heartAlert("좋아요에 추가했습니다.")}
                }
            }
        } else {
            preferenceModel.deleteItems(beer_id: Int(item.beerId!)!) {isValid in
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
    
    // 다른 화면에서 이동후에 첫 실행되는 Method
    override func viewWillAppear(_ animated: Bool) {
        let queryModel = KimQueryModel()
        queryModel.delegate = self
        //          queryModel.downloadItems()
        
        // 창수 추가
        let _ = queryModel.getPriorityList(seq: LOGGED_IN_SEQ) { returnList in
            if returnList.count < 4 {
                queryModel.downloadItems()
            } else {
                queryModel.setItems(first: returnList[0], second: returnList[1], third: returnList[2], fourth: returnList[3]) { isValid in }
            }
        }
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchmyCell", for: indexPath) as! KimTableViewCell
        // Configure the cell...
        let item: KimDBModel = feedItem[indexPath.row] as! KimDBModel // DB 모델타입으로 바꾸고, data 뽑아 쓸 수 있음
        cell.name.text = item.beerName
        cell.style.text = item.beerStyle
        cell.abv.text = item.beerAbv
        cell.review.text = "Feel :\(item.reviewFeel!) Look : \(item.reviewLook!) Smell : \(item.reviewSmell!) Taste : \(item.reviewTaste!)"
        cell.overall.text = item.reviewOverall
        
        if item.beerHeart == 0 {
            cell.btnLike.setImage(no_heart, for: UIControl.State.normal)
        } else {
            cell.btnLike.setImage(heart, for: UIControl.State.normal)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchmyCell"{
            let cell = sender as! UITableViewCell
            let indexPath = self.listTableView.indexPath(for : cell)
            let detailView = segue.destination as! KimDetailViewController
            let item: KimDBModel = feedItem[indexPath!.row] as! KimDBModel // DB 모델타입으로 바꾸고, data 뽑아 쓸 수 있음
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
