//
//  RegisterViewController.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/1/30.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit
import LeanCloud
import ProgressHUD

class RegisterViewController: UIViewController {

    @IBOutlet weak var topLayout: NSLayoutConstraint!
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!

    @IBAction func regist(_ sender: Any) {
        let user = LCUser()
        user.username = LCString(self.userName.text!)
        user.password = LCString(self.password.text!)
        user.email = LCString(self.email.text!)
        user.signUp { (result) in
            switch result{
                case .success:
                    ProgressHUD.showSuccess("注册成功,请验证邮箱")
                    self.dismiss(animated: true, completion: { 
                        
                    })
                    break
                case .failure(let error):
                    ProgressHUD.showSuccess("注册失败,\(error.reason)")
                    break
                }
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true) { 
            
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
