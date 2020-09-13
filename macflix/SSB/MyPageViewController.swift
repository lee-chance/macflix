//
//  MyPageViewController.swift
//  ProjectDraw
//
//  Created by SSB on 12/09/2020.
//  Copyright © 2020 SSB. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogout(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "로그아웃 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        // Closure
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {ACTION in
            UserDefaults.standard.removeObject(forKey: USER_DEFAULT_AUTO_LOGIN_SEQ)
            self.navigationController?.popToRootViewController(animated: true)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func btnWithdrawal(_ sender: UIButton) {
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgUpdateUserInfo"{
            let detailView = segue.destination as! UpdateUserInfoViewController
            detailView.receiveProfilename = LOGGED_IN_PROFILNAME
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
