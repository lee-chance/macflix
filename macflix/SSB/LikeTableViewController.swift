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
        listTableView.rowHeight = 165
        
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
        
        // 사용자의 좋아요 리스트에 선택한 item이 있을 경우
        if LOGGED_IN_HEARTLIST.contains(beerId) {
            preferenceModel.deleteItems(beer_id: beerId) {isValid in // DB 좋아요 리스트에서 삭제
                DispatchQueue.main.async { () -> Void in
                    if isValid {
                        LOGGED_IN_HEARTLIST.remove(at: LOGGED_IN_HEARTLIST.firstIndex(of: beerId)!) // 시스템 상의 좋아요 리스트에서 삭제
                        self.viewWillAppear(true)
                    }
                }
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
        return beerArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myLikeCell", for: indexPath) as! LikeTableViewCell
        
        let item: KimDBModel = beerArray[indexPath.row] as! KimDBModel // DB 모델타입으로 바꾸고 data를 뽑아 쓸 수 있다
        cell.name.text = item.beerName
        cell.style.text = item.beerStyle
        cell.abv.text = "도수 : \(item.beerAbv!)"
        cell.review.text = "Feel :\(item.reviewFeel!) Look : \(item.reviewLook!) Smell : \(item.reviewSmell!) Taste : \(item.reviewTaste!)"
        cell.overall.text = item.reviewOverall
        
        // 맥주 이미지를 웹뷰로 보여주는 부분
        let myURL = URL(string:"https://cdn.beeradvocate.com/im/beers/\(item.beerId!).jpg")
        let myRequest = URLRequest(url: myURL!)
        cell.webView.load(myRequest)
        
        if LOGGED_IN_HEARTLIST.contains(Int(item.beerId!)!) { // 사용자의 좋아요 리스트에 맥주 item이 있다면
            cell.btnLike.setImage(heart, for: UIControl.State.normal) // 버튼을 꽉찬 맥주 이미지로 셋팅
        } else { // 좋아요 리스트에 맥주 item이 없다면
            cell.btnLike.setImage(no_heart, for: UIControl.State.normal) // 버튼을 비어 있는 맥주 이미지로 셋팅
        }
        
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgLikeCell"{
            let cell = sender as! UITableViewCell
            let indexPath = self.listTableView.indexPath(for : cell)
            let detailView = segue.destination as! KimDetailViewController
            // DB 모델타입으로 바꾸고 data를 뽑아 쓸 수 있다
            let item: KimDBModel = beerArray[indexPath!.row] as! KimDBModel
            // detailView로 데이터를 보낸다
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
        }
        
    }
    
    
}

