//
//  LoginViewController.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/1/30.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit
import AVOSCloud

class LoginViewController: UIViewController {

    @IBOutlet weak var topLayout: NSLayoutConstraint!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(_ sender: Any) {
        
        AVUser.logInWithUsername(inBackground: self.userName.text!, password: self.password.text!) { (user, error) in
            if error == nil{
                ProgressHUD.showSuccess("登录成功")
                self.dismiss(animated: true, completion: {
                    
                })
            }else{
                ProgressHUD.showError("用户名或密码错误\(error)")
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
