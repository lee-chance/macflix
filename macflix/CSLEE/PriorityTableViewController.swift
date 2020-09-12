//
//  PriorityTableViewController.swift
//  KNNTest
//
//  Created by Changsu Lee on 2020/09/07.
//  Copyright © 2020 Changsu Lee. All rights reserved.
//

import UIKit

var priority: [String] = []

class PriorityTableViewController: UITableViewController {

    @IBOutlet var listView: UITableView!
    
    var items = ["Smell", "Appearance", "Taste", "Palate"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func btnSubmit(_ sender: UIButton) {
        priority.removeAll()
        for i in 0..<items.count {
            priority.append(((listView.visibleCells[i].textLabel?.text)! as String))
        }
        
        let alertService = AlertService()
        present(alertService.mAlert(alertTitle: "", alertMessage: "Set up!", actionTitle: "Ok", handler: {Void in
            self.navigationController?.popViewController(animated: true)
        }), animated: true)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "preferenceCell", for: indexPath)

        // Configure the cell...
        if priority.isEmpty {
            cell.textLabel?.text = items[(indexPath as NSIndexPath).row]
        } else {
            cell.textLabel?.text = priority[(indexPath as NSIndexPath).row]
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
