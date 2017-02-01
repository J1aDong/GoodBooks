//
//  pushNewBookViewController.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/1/25.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit

class pushNewBookViewController: UIViewController,BookTitleDelegate,PhotoPickerDelegate,VPImageCropperDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var bookTitle:BookTitle?
    
    var tableView:UITableView?
    
    var titleArray:Array<String> = []
    
    var book_title = ""
    
    var ldx_score:LDXScore?
    
    // 是否显示星星
    var ldx_show = false
    
    var type = "文学"
    var detailType = "文学"
    
    var book_description = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.bookTitle = BookTitle(frame: CGRect(x: 0, y: 40, width: SCREEN_WIDTH, height: 160))
        self.bookTitle?.delegate = self
        self.view.addSubview(self.bookTitle!)
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 200, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .grouped)
        // 使没有内容的线条消失
        self.tableView?.tableFooterView = UIView()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView?.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        self.view.addSubview(self.tableView!)
        
        self.titleArray = ["标题","评分","分类","书评"]
        
        self.ldx_score = LDXScore(frame: CGRect(x: 100, y: 10, width: 100, height: 22))
        self.ldx_score?.isSelect = true
        self.ldx_score?.normalImg = UIImage(named: "btn_star_evaluation_normal")
        self.ldx_score?.highlightImg = UIImage(named: "btn_star_evaluation_press")
        self.ldx_score?.max_star = 5
        self.ldx_score?.show_star = 5
    }
    
    deinit {
        print("deinit pushNewBookViewController")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func choiceCover() {
        print("choiceCover")
        
        let vc = photoPickerViewController()
        vc.delegate = self
        self.present(vc, animated: true) {
            
        }
    }
    
    func getImageFromPicker(image: UIImage) {
        let croVC = VPImageCropperViewController(image: image, cropFrame: CGRect(x: 0, y: 100, width: SCREEN_WIDTH, height: SCREEN_WIDTH*1.273), limitScaleRatio: 3)
        croVC?.delegate = self
        self.present(croVC!, animated: true) {
            
        }
        
    }
    
    func imageCropper(_ cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
        self.bookTitle?.bookCover?.setImage(editedImage, for: .normal)
        cropperViewController.dismiss(animated: true) {
            
        }
    }
    
    func imageCropperDidCancel(_ cropperViewController: VPImageCropperViewController!) {
        cropperViewController.dismiss(animated: true) {
            
        }
    }
    
    override func cancel(){
        super.cancel()
        self.dismiss(animated: true) {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.titleArray.count
        print(count)
        return count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        if (indexPath.row != 1) {
            // 添加右边的小箭头
            cell.accessoryType = .disclosureIndicator
        }
        
        cell.textLabel?.text = self.titleArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: MY_FONT, size: 15)
        cell.detailTextLabel?.font = UIFont(name: MY_FONT, size: 13)
        
        var row = indexPath.row
        if self.ldx_show && row>1{
            row -= 1
        }
        switch row {
            case 0:
                cell.detailTextLabel?.text = self.book_title
                break
            case 2:
                cell.detailTextLabel?.text = self.type + "->" + self.detailType
                break
            case 4:
                cell.accessoryType = .none
                let commentView = UITextView(frame: CGRect(x: 4, y: 4, width: SCREEN_WIDTH-8, height: 80))
                commentView.text = self.book_description
                commentView.font = UIFont(name: MY_FONT, size: 14)
                commentView.isEditable = false
                cell.contentView.addSubview(commentView)
                break
            default:
                break
        }
        
        // 是否需要在第二行显示小星星
        if self.ldx_show && indexPath.row == 2{
            cell.contentView.addSubview(self.ldx_score!)
        }
        
        return cell
    }
    
    //    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.ldx_show && indexPath.row > 5 {
            return 88
        }else if !self.ldx_show && indexPath.row > 4 {
            return 88
        }else{
            return 44
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView?.deselectRow(at: indexPath, animated: true)
        var row = indexPath.row
        if self.ldx_show && row>1 {
            row -= 1
        }
        
        switch row {
            case 0:
                self.tableViewSelectTitle()
                break
            case 1:
                self.tableViewSelectScore()
                break
            case 2:
                self.tableViewSelectType()
                break
            case 3:
                self.tableViewSelectDescription()
                break
            default:
                break
        }
    }
    
    //MARK:- 选择标题
    func tableViewSelectTitle(){
        let vc = push_TitleController()
        UiUtil.addTitleWithTitle(target: vc)
        vc.callBack = ({(title:String)->Void in
            self.book_title = title
            self.tableView?.reloadData()
        })
        self.present(vc, animated: true) {
            
        }
    }
    
    //MARK:- 选择评分
    func tableViewSelectScore(){
        self.tableView?.beginUpdates()
        
        // 在第二行插入评分
        let tempIndexPath = [IndexPath(row: 2, section: 0)]

        if self.ldx_show{
            self.titleArray.remove(at: 2)
            self.tableView?.deleteRows(at: tempIndexPath, with: .right)
            self.ldx_show = false
        }else {
            self.titleArray.insert("", at: 2)
            self.tableView?.insertRows(at: tempIndexPath, with: .left)
            self.ldx_show = true
        }

        self.tableView?.endUpdates()
    }
    
    //MARK:- 选择分类
    func tableViewSelectType(){
        let vc = push_TypeViewController()
        UiUtil.addTitleWithTitle(target: vc)
        
        let btn1 = vc.view.viewWithTag(1234) as? UIButton
        let btn2 = vc.view.viewWithTag(1235) as? UIButton
        btn1?.setTitleColor(RGB(r: 38, g: 82, b: 67), for: .normal)
        btn2?.setTitleColor(RGB(r: 38, g: 82, b: 67), for: .normal)
        vc.type = self.type
        vc.detailType = self.detailType
        vc.callBack = ({(type:String,detailType:String)->Void in
            self.type = type
            self.detailType = detailType
            self.tableView?.reloadData()
        })
        
        self.present(vc, animated: true) {
            
        }
    }
    
    //MARK:- 选择书评
    func tableViewSelectDescription(){
        let vc = push_DescriptionViewController()
        UiUtil.addTitleWithTitle(target: vc)
        vc.textView?.text = self.book_description
        vc.callBack = ({(description:String)->Void in
            self.book_description = description
            
            if self.titleArray.last == ""{
                self.titleArray.removeLast()
            }
            if description != ""{
                self.titleArray.append("")
            }
            self.tableView?.reloadData()
        })
        self.present(vc, animated: true) {
            
        }
    }
}
