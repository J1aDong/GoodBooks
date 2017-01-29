//
//  push_TitleController.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/1/29.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit

typealias Push_TitleCalBack = (_ title:String)->Void

class push_TitleController: UIViewController {
    
    var textField:UITextField?
    var callBack:Push_TitleCalBack?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.textField = UITextField(frame: CGRect(x: 15, y: 60, width: SCREEN_WIDTH-30, height: 30))
        self.textField?.borderStyle = .roundedRect
        self.textField?.placeholder = "书评标题"
        self.textField?.font = UIFont(name: MY_FONT, size: 15)
        self.view.addSubview(self.textField!)
        
        self.textField?.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func confirm() {
        self.callBack?((self.textField?.text!)!)
        self.dismiss(animated: true) { 
            
        }
    }

    override func cancel(){
        super.cancel()
        self.dismiss(animated: true) {

        }
    }

}
