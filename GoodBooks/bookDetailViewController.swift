//
//  bookDetailViewController.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/2/2.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit
import AVOSCloud

class bookDetailViewController: UIViewController,BookTabBarDelegate,InputViewDelegate {
    
    var bookObject:AVObject?
    var bookDetail:bookDetailView?
    var bookViewTabbar:BookTabBar?
    var bookTextView:UITextView?
    var input:InputView?
    var layView:UIView?
    
    // 记录键盘的高度
    var keyBoardHeight:CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        
        self.initBookDetailView()
        
        self.bookViewTabbar = BookTabBar(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 40, width: SCREEN_WIDTH, height: 40))
        self.view.addSubview(bookViewTabbar!)
        self.bookViewTabbar?.delegate = self
        
        self.bookTextView = UITextView(frame: CGRect(x: 0, y: 64+SCREEN_HEIGHT/4, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-SCREEN_HEIGHT/4-40))
        self.bookTextView?.isEditable = false
        self.bookTextView?.text = self.bookObject!["description"] as? String
        self.view.addSubview(self.bookTextView!)
        
        self.isLove()
    }
    
    func comment() {
        if self.input == nil{
            self.input = Bundle.main.loadNibNamed("InputView", owner: self, options: nil)?.last as? InputView
            self.input?.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 44, width: SCREEN_WIDTH, height: 44)
            self.input?.delegate = self
            self.view.addSubview(self.input!)
        }
        if self.layView == nil{
            self.layView = UIView(frame: self.view.frame)
            self.layView?.backgroundColor = UIColor.gray
            self.layView?.alpha = 0
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapInputView))
            self.layView?.addGestureRecognizer(tap)
        }
        self.view.insertSubview(self.layView!, belowSubview: self.input!)
        self.layView?.isHidden = false
        self.input?.inputTextView.becomeFirstResponder()
    }
    
    func tapInputView(){
        self.input?.inputTextView.resignFirstResponder()
    }
    
    //MARK:- 键盘的出现消失
    func textViewHeightDidChange(_ height: CGFloat) {
        self.input?.height = height+10
        self.input?.bottom = SCREEN_HEIGHT - self.keyBoardHeight
    }
    
    func publishButtonDidClick(_ button: UIButton!) {
        let object = AVObject(className: "discuss")
        object.setObject(self.input?.inputTextView.text, forKey: "text")
        object.setObject(AVUser.current(), forKey: "user")
        object.setObject(self.bookObject, forKey: "BookObject")
        object.saveInBackground { (success, error) in
            if success{
                self.input?.inputTextView.resignFirstResponder()
                ProgressHUD.showSuccess("评论成功")
            }else{
                
            }
        }
    }
    
    
    func keyboardWillHide(_ inputView: InputView!, keyboardHeight: CGFloat, animationDuration duration: TimeInterval, animationCurve: UIViewAnimationCurve) {
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .beginFromCurrentState, animations: { 
            self.input?.bottom = SCREEN_HEIGHT+(self.input?.height)!
            self.layView?.alpha = 0
        }) { (finish) in
            self.layView?.isHidden = true
        }
    }
    
    func keyboardWillShow(_ inputView: InputView!, keyboardHeight: CGFloat, animationDuration duration: TimeInterval, animationCurve: UIViewAnimationCurve) {
        self.keyBoardHeight = keyboardHeight
        UIView.animate(withDuration: duration, delay: 0, options: .beginFromCurrentState, animations: {
            self.input?.bottom = SCREEN_HEIGHT - keyboardHeight
            self.layView?.alpha = 0.2
        }) { (finish) in
            
        }
    }
    
    func commentController() {
        let vc = commentViewController()
        UiUtil.addTitleWithTitle(target: vc, title1: "", title2: "关闭")
        vc.bookObject = self.bookObject
        vc.tableView?.mj_header.beginRefreshing()
        self.present(vc, animated: true) { 
            
        }
    }
    
    func likeBook(_ btn:UIButton) {
        
        btn.isEnabled = false
        btn.setImage(UIImage(named: "redheart"), for: .normal)
        
        let query = AVQuery(className: "Love")
        query.whereKey("user", equalTo: AVUser.current()!)
        query.whereKey("BookObject", equalTo: self.bookObject!)
        query.findObjectsInBackground { (results, error) in
            if results != nil && results?.count != 0{
                for object in results!{
                    let avo = object as? AVObject
                    avo?.deleteEventually()
                }
                btn.setImage(UIImage(named: "heart"), for: .normal)
            }else{
                let object = AVObject(className: "Love")
                object.setObject(AVUser.current(), forKey: "user")
                object.setObject(self.bookObject, forKey: "BookObject")
                object.saveInBackground({ (success, error) in
                    if success{
                        btn.setImage(UIImage(named: "solidheart"), for: .normal)
                    }else{
                        ProgressHUD.showError("操作失败")
                    }
                })
            }
            btn.isEnabled = true
        }
    }
    
    func shareAction() {
        print("3")
    }
    
    //MARK:- 是否点赞初始化
    func isLove(){
        let query = AVQuery(className: "Love")
        query.whereKey("user", equalTo: AVUser.current()!)
        query.whereKey("BookObject", equalTo: self.bookObject!)
        query.findObjectsInBackground { (results, error) in
            if results != nil && results?.count != 0{
                let btn = self.bookViewTabbar?.viewWithTag(2) as? UIButton
                btn?.setImage(UIImage(named: "solidheart"), for: .normal)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 初始化
    func initBookDetailView(){
        self.bookDetail = bookDetailView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT/4))
        self.view.addSubview(self.bookDetail!)
        
        let coverFile = self.bookObject!["cover"] as? AVFile
        self.bookDetail?.cover?.sd_setImage(with: URL(string: (coverFile?.url)!), placeholderImage: UIImage(named: "Cover"))
        self.bookDetail?.bookName?.text = "《\(self.bookObject?["BookName"] as! String)》"
        self.bookDetail?.editor?.text = "作者:\(self.bookObject?["BookEditor"] as! String)"
        
        let user = self.bookObject!["user"] as? AVUser
        user?.fetchInBackground({ (user, error) in
            self.bookDetail?.userName?.text = "编者:\((user as! AVUser).username!)"
        })
        
        let date = self.bookObject!["createdAt"] as? Date
        let format = DateFormatter()
        format.dateFormat = "yy-MM-dd"
        self.bookDetail?.date?.text = format.string(from: date!)
        
        let scoreString = self.bookObject!["score"] as? String
        self.bookDetail?.scroe?.show_star = Int(scoreString!)!
        
        self.bookDetail?.more?.text = "65个喜欢，5次评论，12000次浏览"
    }

}
