//
//  MypageTableViewController.swift
//  ProjectDraw
//
//  Created by SSB on 10/09/2020.
//  Copyright © 2020 SSB. All rights reserved.
//

import UIKit

class UserPriorityTableViewController: UITableViewController, PriorityModelProtocol {
    
    @IBOutlet var listTableView: UITableView!
    
    var priority: [String] = []
    var items: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) { // 선택하기 버튼을 눌렀을 경우
        items.removeAll()
        
        for i in 0..<priority.count { // 데이터베이스에서 가져온 사용자의 취향 우선순위 리스트의 개수만큼 반복
            // 비어있는 배열에 사용자가 수정한 우선순위 리스트를 하나씩 append
            items.append(((listTableView.visibleCells[i].textLabel?.text)! as String))
        }
        
        let preferenceModel = PreferenceModel()
        let items2 = items.joined(separator: ", ") // 배열의 문자들을 ,을 구분자로 하나로 연결한다
        preferenceModel.updateUserPriorityItems(user_priority: items2){isValid in
            DispatchQueue.main.async { () -> Void in
                if isValid {
                    self.alert()}
            }
        }
    }
    
    func alert() {
        let alert = UIAlertController(title: nil, message: "선택완료!", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {ACTION in
            self.navigationController?.popViewController(animated: true)
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) { // 화면이 나타날 때
        let queryModel = UserPriorityQueryModel()
        queryModel.delegate = self
        queryModel.getPriorityList()
    }
    
    func itemDownloaded(items: [String]) {
        priority = items
        self.listTableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return priority.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPriorityCell", for: indexPath)
        
        // 사용자가 선택한 맥주 취향의 우선순위를 보여준다
        cell.textLabel?.text = priority[(indexPath as NSIndexPath).row].replacingOccurrences(of: " ", with: "")
        
        return cell
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }

    
}
