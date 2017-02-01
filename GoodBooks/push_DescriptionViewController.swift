//
//  push_DescriptionViewController.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/1/29.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

typealias Push_DescriptionControllerblock = (_ description:String)->Void

class push_DescriptionViewController: UIViewController {
    
    var textView:JVFloatLabeledTextView?
    var callBack:Push_DescriptionControllerblock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.textView = JVFloatLabeledTextView(frame: CGRect(x: 8, y: 58, width: SCREEN_WIDTH-16, height: SCREEN_HEIGHT-58-8))
        self.view.addSubview(self.textView!)
        self.textView?.placeholder = "  您可以在这里撰写详细的评价、吐槽、介绍~~"
        self.textView?.font = UIFont(name: MY_FONT, size: 17)
        self.view.tintColor = UIColor.gray
        self.textView?.becomeFirstResponder()
        
        XKeyBoard.registerHide(self)
        XKeyBoard.registerShow(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func confirm() {
        self.callBack?((self.textView?.text)!)
        self.dismiss(animated: true) {
            
        }
    }
    
    override func cancel(){
        super.cancel()
        self.dismiss(animated: true) {
            
        }
    }
    
    //MARK:- 键盘遮挡
    func keyboardWillShowNotification(_ notification:Notification){
        let rect = XKeyBoard.returnWindow(notification)
        self.textView?.contentInset = UIEdgeInsetsMake(0, 0, rect.size.height, 0)
    }
    
    func keyboardWillHideNotification(_ notification:Notification){
        self.textView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
}
