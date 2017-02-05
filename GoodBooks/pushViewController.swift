//
//  pushViewController.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/1/24.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit
import AVOSCloud
import SDWebImage
import SWTableViewCell

class pushViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate {
    
    var dataArray = NSMutableArray()
    var navigationView:UIView!
    var tableView:UITableView?
    
    var swipIndexPath:IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.

        self.setNavigationBar()
        
        self.tableView = UITableView(frame: self.view.frame)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.view.addSubview(self.tableView!)
        self.tableView?.register(pushBook_Cell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView?.tableFooterView = UIView()
        
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.headerRefresh))
        self.tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.footerRefresh))
        self.tableView?.mj_header.beginRefreshing()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationView.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView?.deselectRow(at: indexPath, animated: true)
        
        let vc = bookDetailViewController()
        vc.bookObject = self.dataArray[indexPath.row] as? AVObject
        vc.hidesBottomBarWhenPushed = true
        
        self.navigationItem.title = ""
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 下拉刷新
    func headerRefresh(){
        let query = AVQuery(className: "Book")
        query.order(byDescending: "createdAt")
        query.limit = 20
        query.skip = 0
        query.whereKey("user", equalTo: AVUser.current()!)
        query.findObjectsInBackground { (results, error) in
            // 停止刷新
            self.tableView?.mj_header.endRefreshing()
            
            if results != nil {
                self.dataArray.removeAllObjects()
                self.dataArray.addObjects(from: results!)
                self.tableView?.reloadData()
            }
            
        }
    }
    
    // 上拉加载
    func footerRefresh(){
        let query = AVQuery(className: "Book")
        query.order(byDescending: "createdAt")
        query.limit = 20
        query.skip = self.dataArray.count
        query.whereKey("user", equalTo: AVUser.current()!)
        query.findObjectsInBackground { (results, error) in
            // 停止刷新
            self.tableView?.mj_footer.endRefreshing()
            
            self.dataArray.addObjects(from: results!)
            self.tableView?.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setNavigationBar() {
        navigationView = UIView(frame: CGRect(x: 0, y: -20, width: SCREEN_WIDTH, height: 65))
        navigationView.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.addSubview(navigationView)

        let addBookBtn = UIButton(frame: CGRect(x: 20, y: 20, width: SCREEN_HEIGHT, height: 45))
        addBookBtn.setImage(UIImage(named: "plus circle"), for: .normal)
        addBookBtn.showsTouchWhenHighlighted = true
        addBookBtn.setTitleColor(UIColor.black, for: .normal)
        addBookBtn.setTitle(" 新建书评", for: .normal)
        addBookBtn.titleLabel?.font = UIFont(name: MY_FONT, size: 15)
        // 按钮文字显示居左
        addBookBtn.contentHorizontalAlignment = .left
        addBookBtn.addTarget(self, action: #selector(self.pushNewBook), for: .touchUpInside)
        navigationView.addSubview(addBookBtn)

    }

    func pushNewBook() {
        let vc = pushNewBookViewController()
        UiUtil.addTitleWithTitle(target: vc,title1: "关闭",title2: "发布")
        self.present(vc, animated: true) {

        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView?.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as?pushBook_Cell
        
        cell?.rightUtilityButtons = self.returnRightBtn()
        cell?.delegate = self
        
        let dict = self.dataArray[indexPath.row] as? AVObject
        
        cell?.bookName?.text = "《\(dict!["BookName"] as! String)》:\(dict!["title"] as! String)"
        cell?.editor?.text = "作者:\(dict!["BookEditor"] as! String)"
        
        let date = dict!["createdAt"] as! Date
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd hh:mm"
        cell?.more?.text = format.string(from: date)
        
        let coverFile = dict!["cover"] as? AVFile
        cell?.cover?.sd_setImage(with: URL(string: (coverFile?.url)!), placeholderImage: UIImage(named: "Cover"))
        
        return cell!
    }
    
    func swipeableTableViewCell(_ cell: SWTableViewCell!, scrollingTo state: SWCellState) {
        let indexPath = self.tableView?.indexPath(for: cell)
        if state == .cellStateRight{
            if self.swipIndexPath != nil && self.swipIndexPath?.row != indexPath?.row{
                let swipeCell = self.tableView?.cellForRow(at: self.swipIndexPath!) as? pushBook_Cell
                swipeCell?.hideUtilityButtons(animated: true)
            }
            self.swipIndexPath = indexPath
        }else if state == .cellStateCenter{
            self.swipIndexPath = nil
        }
    }
    
    func swipeableTableViewCell(_ cell: SWTableViewCell!, didTriggerRightUtilityButtonWith index: Int) {
        let indexPath = self.tableView?.indexPath(for: cell)
        
        let object = self.dataArray[indexPath!.row] as? AVObject
        
        // 编辑
        if index == 0{
            let vc = pushNewBookViewController()
            UiUtil.addTitleWithTitle(target: vc, title1: "关闭", title2: "发布")
            vc.fixType = "fix"
            vc.bookObject = object
            vc.fixBook()
            self.present(vc, animated: true, completion: { 
                
            })
        }
        // 删除
        else{
            // 删除评论
            let discussQuery = AVQuery(className: "discuss")
            discussQuery.whereKey("BookObject", equalTo: object!)
            discussQuery.findObjectsInBackground({ (results, error) in
                for Book in results!{
                    let bookObject = Book as? AVObject
                    bookObject?.deleteInBackground()
                }
            })
            
            let loveQuery = AVQuery(className: "Love")
            loveQuery.whereKey("BookObejct", equalTo: object!)
            loveQuery.findObjectsInBackground({ (results, error) in
                for Book in results!{
                    let bookObject = Book as? AVObject
                    bookObject?.deleteInBackground()
                }
            })
            
            object?.deleteInBackground({ (success, error) in
                if success {
                    ProgressHUD.showSuccess("删除成功")
                    self.dataArray.removeObject(at: (indexPath?.row)!)
                    self.tableView?.reloadData()
                }
            })
            
        }
        
    }
    
    func returnRightBtn()->[AnyObject]{
        let btn1 = UIButton(frame: CGRect(x: 0, y: 0, width: 88, height: 88))
        btn1.backgroundColor = UIColor.orange
        btn1.setTitle("编辑", for: .normal)
        
        let btn2 = UIButton(frame: CGRect(x: 0, y: 0, width: 88, height: 88))
        btn2.backgroundColor = UIColor.red
        btn2.setTitle("删除", for: .normal)
        
        return [btn1,btn2]
    }
}
