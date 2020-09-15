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
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        items.removeAll()
        for i in 0..<priority.count {
            items.append(((listTableView.visibleCells[i].textLabel?.text)! as String))
        }
        
        let preferenceModel = PreferenceModel()
        let items2 = items.joined(separator: ", ")
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
    
    override func viewWillAppear(_ animated: Bool) {
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
        cell.textLabel?.text = priority[(indexPath as NSIndexPath).row].replacingOccurrences(of: " ", with: "")

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

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
        

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
