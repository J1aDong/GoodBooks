//
//  LoginViewController.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/1/30.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit
import LeanCloud
import ProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var topLayout: NSLayoutConstraint!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(_ sender: Any) {
        LCUser.logIn(username: self.userName.text!, password: self.password.text!) { (result) in
            switch result{
                case .success( _):
                    ProgressHUD.showSuccess("登录成功")
                    self.dismiss(animated: true, completion: {
                        
                    })
                    break
                case .failure(let error):
                    ProgressHUD.showError("登录失败\(error.reason)")
                    break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        XKeyBoard.registerHide(self)
        XKeyBoard.registerShow(self)
    }
    
    func keyboardWillShowNotification(_ notification:NSNotification){
        UIView.animate(withDuration: 0.3) { 
            self.topLayout.constant = -200
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHideNotification(_ notification:NSNotification){
        UIView.animate(withDuration: 0.3) {
            self.topLayout.constant = 8
            self.view.layoutIfNeeded()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
