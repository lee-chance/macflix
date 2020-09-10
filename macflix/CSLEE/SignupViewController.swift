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
        let alertService = AlertService()
        
        guard lblEmail.text!.count > 0 else {
            present(alertService.mAlert(alertTitle: "Error", alertMessage: "Fill out E-MAIL field!", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
            return
        }
        
        guard validateEmail(email: lblEmail.text!) else {
            present(alertService.mAlert(alertTitle: "Error", alertMessage: "Invalid E-MAIL.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
            return
        }
        
        guard lblPassword.text!.count > 0 else {
            present(alertService.mAlert(alertTitle: "Error", alertMessage: "Fill out PASSWORD field.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
            return
        }
        
//        guard validPassword(password: lblPassword.text!) else {
//            present(alertService.mAlert(alertTitle: "Error", alertMessage: "Invalid PASSWORD.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
//            return
//        }
        
        guard lblNickname.text!.count > 0 else {
            present(alertService.mAlert(alertTitle: "Error", alertMessage: "Fill out NICKNAME field.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
            return
        }
        
        if let email = lblEmail.text,
           let password = lblPassword.text,
           let nickname = lblNickname.text {
            let signupModel = SignupModel()
            
            signupModel.actionSignup(email: email, password: password, nickname: nickname, priority: priority) { isValid in
                DispatchQueue.main.async { () -> Void in
                    if isValid {
                        self.present(alertService.mAlert(alertTitle: "Signed up!", alertMessage: "Signed up successfully.", actionTitle: "Ok", handler: {Void in
                            self.navigationController?.popViewController(animated: true)
                        }), animated: true, completion: nil)
                    } else {
                        self.present(alertService.mAlert(alertTitle: "Error", alertMessage: "An error has occurred.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func validateEmail(email: String) -> Bool {
        let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
//    public func validPassword(password: String) -> Bool {
//        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
//        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
//    }
    
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
