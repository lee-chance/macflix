//
//  SignupViewController.swift
//  KNNTest
//
//  Created by Changsu Lee on 2020/09/08.
//  Copyright © 2020 Changsu Lee. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var lblEmail: UITextField!
    @IBOutlet weak var lblPassword: UITextField!
    @IBOutlet weak var lblNickname: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSignup(_ sender: UIButton) {
        print(priority)
        let alertService = AlertService()
        
        guard lblEmail.text!.count > 0 else {
            present(alertService.mAlert(alertTitle: "Error", alertMessage: "You have to fill E-MAIL field.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
            return
        }
        
        guard lblPassword.text!.count > 0 else {
            present(alertService.mAlert(alertTitle: "Error", alertMessage: "You have to fill PASSWORD field.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
            return
        }
        
        guard lblNickname.text!.count > 0 else {
            present(alertService.mAlert(alertTitle: "Error", alertMessage: "You have to fill NICKNAME field.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
            return
        }
        
        if let email = lblEmail.text,
           let password = lblPassword.text,
           let nickname = lblNickname.text {
            let signupModel = SignupModel()
            let result = signupModel.actionSignup(email: email, password: password, nickname: nickname, priority: priority)
            
            if result {
                present(alertService.mAlert(alertTitle: "Signed up!", alertMessage: "Signed up successfully.", actionTitle: "Ok", handler: {Void in
                    self.navigationController?.popViewController(animated: true)
                }), animated: true, completion: nil)
            } else {
                present(alertService.mAlert(alertTitle: "Error", alertMessage: "An error has occurred.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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
