//
//  MyPageViewController.swift
//  ProjectDraw
//
//  Created by SSB on 12/09/2020.
//  Copyright © 2020 SSB. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {
    
    let alertService = AlertService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnLogout(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "로그아웃 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        // Closure
        let okAction = UIAlertAction(title: "로그아웃", style: UIAlertAction.Style.default, handler: {ACTION in
            UserDefaults.standard.removeObject(forKey: USER_DEFAULT_AUTO_LOGIN_SEQ)
            self.navigationController?.popToRootViewController(animated: true)
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    func alertCheckPassword() {
        let deleteModel = PreferenceModel()
        deleteModel.UserDelete() {isValid in
            DispatchQueue.main.async { () -> Void in
                if isValid {
                    self.present(self.alertService.mAlert(alertTitle: "", alertMessage: "정상적으로 회원탈퇴 되었습니다.", actionTitle: "확인", handler: {Void in
                        UserDefaults.standard.removeObject(forKey: USER_DEFAULT_AUTO_LOGIN_SEQ)
                        self.navigationController?.popToRootViewController(animated: true)
                    }), animated: true)
                    
                }
            }
        }
    }
    
    @IBAction func btnWithdrawal(_ sender: UIButton) {
        let checkModel = UpdateUserInfoModel()
        
        let alert = UIAlertController(title: nil, message: "회원탈퇴 하시겠습니까?", preferredStyle: .alert)
        
        alert.addTextField { (myTextField) in
            myTextField.isSecureTextEntry = true
            myTextField.placeholder = "비밀번호를 입력해주세요."
        }
        
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {ACTION in
            checkModel.checkPwd(user_password: (alert.textFields?[0].text!)!) {isValid in
                DispatchQueue.main.async { () -> Void in
                    if isValid {
                        self.alertCheckPassword()
                    }
                    else {
                        self.present(self.alertService.mAlert(alertTitle: "", alertMessage: "비밀번호가 일치하지 않습니다.", actionTitle: "확인", handler: nil), animated: true, completion: nil)
                    }
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }

    
}
