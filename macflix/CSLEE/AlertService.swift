//
//  AlertClass.swift
//  KNNTest
//
//  Created by Changsu Lee on 2020/09/08.
//  Copyright © 2020 Changsu Lee. All rights reserved.
//

import UIKit

class AlertService {
    
    func mAlert(alertTitle: String, alertMessage: String, actionTitle: String, handler:((UIAlertAction) -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: handler)
        
        alert.addAction(action)
        return alert
    }
    
}


