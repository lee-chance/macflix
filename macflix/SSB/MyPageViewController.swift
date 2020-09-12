//
//  MyPageViewController.swift
//  ProjectDraw
//
//  Created by SSB on 12/09/2020.
//  Copyright © 2020 SSB. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController, ProfilenameModelProtocol {
    
    var profilename: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let queryModel = UserProfilenameModel()
        queryModel.delegate = self
        queryModel.getProfilename()
    }
        
    func itemDownloaded(items: String) {
        profilename = items
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgUpdateUserInfo"{
            let detailView = segue.destination as! UpdateUserInfoViewController
            detailView.receiveProfilename = profilename
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
