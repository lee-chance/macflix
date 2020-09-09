//
//  TableViewController.swift
//  KNNTest
//
//  Created by Changsu Lee on 2020/09/05.
//  Copyright © 2020 Changsu Lee. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, QueryModelProtocol {

    @IBOutlet var listView: UITableView!
    
    var feedItem: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listView.delegate = self
        self.listView.dataSource = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func itemDownloaded(items: NSArray) {
        feedItem = items
        self.listView.reloadData()
    }
    
    @IBAction func btnRemoveAutoLogin(_ sender: UIBarButtonItem) {
        UserDefaults.standard.removeObject(forKey: USER_DEFAULT_AUTO_LOGIN_EMAIL)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let queryState = UserDefaults.standard.integer(forKey: USER_DEFAULT_QUERY_STATE)
        switch queryState {
//            case QUERY:
//                let queryModel = QueryModel()
//                queryModel.delegate = self
//                queryModel.downloadItems()
            case PRIORITY_QUERY:
                let queryModel = PriorityQueryModel()
                queryModel.delegate = self
                let _ = queryModel.getPriorityList(email: LOGGED_IN_EMAIL) { returnList in
                    if returnList.count < 2 {
                        let queryModel = QueryModel()
                        queryModel.delegate = self
                        queryModel.downloadItems()
                    } else {
                        queryModel.setItems(first: returnList[0], second: returnList[1], third: returnList[2], fourth: returnList[3]) { isValid in }
                    }
                }
            default:
                break
        }
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 100
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // Configure the cell...
        if(feedItem.count > 0) {
            let item: Beer = feedItem[indexPath.row] as! Beer
            cell.textLabel?.text = item.beer_name
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
