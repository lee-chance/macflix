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
    
    var passwordResult : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblUserNickname.text = LOGGED_IN_PROFILENAME
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
                        self.present(alertService.mAlert(alertTitle: "", alertMessage: "닉네임 변경에 성공하셨습니다.", actionTitle: "Ok", handler: {Void in
                            LOGGED_IN_PROFILENAME = profilename
                            self.navigationController?.popViewController(animated: true)
                        }), animated: true, completion: nil)
                    } else {
                        self.present(alertService.mAlert(alertTitle: "", alertMessage: "닉네임 변경에 실패하셨습니다.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
                    }
                }
            }
            
        }
    }
    
    @IBAction func updatePassword(_ sender: UIButton) {
        let alertService = AlertService()
        
        guard lblUserPassword.text!.count > 0 else {
            present(alertService.mAlert(alertTitle: "", alertMessage: "기존 패스워드 칸을 입력해주세요.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
            return
        }
        
        guard lblUserNewPassword.text!.count > 0 else {
            present(alertService.mAlert(alertTitle: "", alertMessage: "신규 패스워드 칸을 입력해주세요.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
            return
        }
        
        guard lblUserNewPasswordCheck.text!.count > 0 else {
            present(alertService.mAlert(alertTitle: "", alertMessage: "신규 패스워드 확인 칸을 입력해주세요.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
            return
        }
        
        guard lblUserNewPassword.text == lblUserNewPasswordCheck.text else {
            present(alertService.mAlert(alertTitle: "", alertMessage: "신규 비밀번호가 일치하지 않습니다.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)
            return
        }
        
        if let newPassword = lblUserNewPassword.text,
           let currentPassword = lblUserPassword.text {
            let updateModel = UpdateUserInfoModel()
            
            updateModel.checkPwd(user_password: currentPassword) { isValid in
                DispatchQueue.main.async { () -> Void in
                    if isValid {
                        updateModel.updateUserPassword(user_password: newPassword) { isValid in
                            DispatchQueue.main.async { () -> Void in
                                if isValid {
                                    self.present(alertService.mAlert(alertTitle: "", alertMessage: "패스워드 변경에 성공하셨습니다.", actionTitle: "Ok", handler: {Void in
                                        UserDefaults.standard.removeObject(forKey: USER_DEFAULT_AUTO_LOGIN_SEQ)
                                        self.navigationController?.popToRootViewController(animated: true)
                                    }), animated: true, completion: nil)
                                } else {
                                    self.present(alertService.mAlert(alertTitle: "", alertMessage: "패스워드 변경에 실패하셨습니다.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)}
                            }
                        }
                    } else {
                        self.present(alertService.mAlert(alertTitle: "", alertMessage: "기존 비밀번호가 일치하지 않습니다.", actionTitle: "Ok", handler: nil), animated: true, completion: nil)}
                }
            }
        }
    }

    
}
