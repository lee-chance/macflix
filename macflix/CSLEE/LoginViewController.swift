//
//  LoginViewController.swift
//  KNNTest
//
//  Created by Changsu Lee on 2020/09/08.
//  Copyright © 2020 Changsu Lee. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var lblEmail: UITextField!
    @IBOutlet weak var lblPassword: UITextField!
    @IBOutlet weak var swAutoLogin: UISwitch!
    @IBOutlet weak var btnFindPassword: UIButton!
    
    var autoLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnFindPassword.addTarget(self, action: #selector(defaultAlert(_:)), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
        let autoLoginSeq = UserDefaults.standard.integer(forKey: USER_DEFAULT_AUTO_LOGIN_SEQ)
        if autoLoginSeq != 0 {
            loginWithStaticDatas(user_seq: autoLoginSeq)
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
            NotificationCenter.default.post(name: heartAttackNotificationName, object: nil)
        }
    }
    
    func loginWithStaticDatas(user_seq: Int) {
        self.performSegue(withIdentifier: "sgLogin", sender: self)
        LOGGED_IN_SEQ = user_seq
        UserDefaults.standard.set(1, forKey: USER_DEFAULT_QUERY_STATE)
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        if let email = lblEmail.text,
            let password = lblPassword.text {
            let loginModel = LoginModel()
            loginModel.actionLogin(email: email, password: password) { resultSeq in
                DispatchQueue.main.async { () -> Void in
                    if resultSeq != 0 {
                        if self.autoLogin {
                            UserDefaults.standard.set(resultSeq, forKey: USER_DEFAULT_AUTO_LOGIN_SEQ)
                        }
                        self.loginWithStaticDatas(user_seq: resultSeq)
                    } else {
                        let alertService = AlertService()
                        self.present(alertService.mAlert(alertTitle: "Login Failed", alertMessage: "Check your e-mail or password.", actionTitle: "Ok", handler: nil), animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func toggleAutoLogin(_ sender: UISwitch) {
        autoLogin = sender.isOn
    }
    
    @objc func defaultAlert(_ sender: Any){
        //알림창을 정의
        let alert = UIAlertController(title: "Find Password", message: "send a new password to your email", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {myTextField in
            myTextField.placeholder = "email"
        })
        //버튼을 정의
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        //알림창에 버튼 추가
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        //알림창 화면에 표시
        present(alert, animated: false)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "sgLogin" {
//            if loginResult {
//                print("ok")
//            } else {
//                print("not ok")
//            }
//        }
//    }


}
