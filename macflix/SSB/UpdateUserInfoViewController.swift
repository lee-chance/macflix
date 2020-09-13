//
//  UpdateUserInfoViewController.swift
//  ProjectDraw
//
//  Created by SSB on 11/09/2020.
//  Copyright © 2020 SSB. All rights reserved.
//

import UIKit

class UpdateUserInfoViewController: UIViewController {

    
    
    @IBOutlet weak var lblUserNickname: UITextField!
    
    @IBOutlet weak var lblUserPassword: UITextField!
    @IBOutlet weak var lblUserNewPassword: UITextField!
    @IBOutlet weak var lblUserNewPasswordCheck: UITextField!

    //var receiveProfilename : String = ""
    var passwordResult : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblUserNickname.text = LOGGED_IN_PROFILNAME
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }

    @IBAction func updateProfilename(_ sender: UIButton) {
        let alertService = AlertService()
        
        if let profilename = lblUserNickname.text {
            let updateModel = UpdateUserInfoModel()
            
            updateModel.updateUserProfilename(user_profilename: profilename) { isValid in
                DispatchQueue.main.async { () -> Void in
                    if isValid {
                        self.present(alertService.mAlert(alertTitle: "", alertMessage: "Nickname change complete.", actionTitle: "Ok", handler: {Void in
                            LOGGED_IN_PROFILNAME = profilename
                            self.navigationController?.popViewController(animated: true)
                        }), animated: true, completion: nil)
                    } else {
                        self.present(alertService.mAlert(alertTitle: "Error", alertMessage: "An error has occurred.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
                    }
                }
            }

        }
    }
    
//    func currentPasswordCheck(_ password: String) {
//        let userInfoModel = UpdateUserInfoModel()
//        userInfoModel.checkPwd(user_password: password) { isValid in
//            DispatchQueue.main.async { () -> Void in
//                self.passwordResult = isValid
//            }
//        }
//    }
    
    
    @IBAction func updatePassword(_ sender: UIButton) {
        let alertService = AlertService()
 
        guard lblUserPassword.text!.count > 0 else {
            present(alertService.mAlert(alertTitle: "Error", alertMessage: "Fill out Current PASSWORD field.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
            return
        }
        
        guard lblUserNewPassword.text!.count > 0 else {
            present(alertService.mAlert(alertTitle: "Error", alertMessage: "Fill out New PASSWORD field.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
            return
        }
        
        guard lblUserNewPasswordCheck.text!.count > 0 else {
            present(alertService.mAlert(alertTitle: "Error", alertMessage: "Fill out New PASSWORD Check field.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
            return
        }
        
        guard lblUserNewPassword.text == lblUserNewPasswordCheck.text else {
            present(alertService.mAlert(alertTitle: "Error", alertMessage: "신규 비밀번호가 일치하지 않습니다.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
            return
        }
        
//        currentPasswordCheck(lblUserPassword.text!)
//
//        guard passwordResult == true else{
//            present(alertService.mAlert(alertTitle: "Error", alertMessage: "기존 비밀번호가 일치하지 않습니다.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
//            return
//        }
            
        if let newPassword = lblUserNewPassword.text,
            let currentPassword = lblUserPassword.text {
            let updateModel = UpdateUserInfoModel()
            
            updateModel.checkPwd(user_password: currentPassword) { isValid in
                DispatchQueue.main.async { () -> Void in
                    if isValid {
                        updateModel.updateUserPassword(user_password: newPassword) { isValid in
                            DispatchQueue.main.async { () -> Void in
                                if isValid {
                                    self.present(alertService.mAlert(alertTitle: "", alertMessage: "Password change complete.", actionTitle: "Ok", handler: {Void in
                                        UserDefaults.standard.removeObject(forKey: USER_DEFAULT_AUTO_LOGIN_SEQ)
                                        self.navigationController?.popToRootViewController(animated: true)
                                    }), animated: true, completion: nil)
                                } else {
                                    self.present(alertService.mAlert(alertTitle: "Error", alertMessage: "An error has occurred.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)}
                            }
                        }
                    } else {
                        self.present(alertService.mAlert(alertTitle: "Error", alertMessage: "기존 비밀번호가 일치하지 않습니다.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)}
                }
            }
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
