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
        return self.titleArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        if indexPath.row != 1 {
            // 添加右边的小箭头
            cell.accessoryType = .disclosureIndicator
        }
        
        cell.textLabel?.text = self.titleArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: MY_FONT, size: 15)
        cell.detailTextLabel?.font = UIFont(name: MY_FONT, size: 13)
        switch indexPath.row {
        case 0:
            cell.detailTextLabel?.text = self.book_title
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView?.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
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
        
    }
    
    //MARK:- 选择分类
    func tableViewSelectType(){
        let vc = push_TypeViewController()
        UiUtil.addTitleWithTitle(target: vc)
        self.present(vc, animated: true) {
            
        }
    }
    
    //MARK:- 选择书评
    func tableViewSelectDescription(){
        let vc = push_DescriptionViewController()
        UiUtil.addTitleWithTitle(target: vc)
        self.present(vc, animated: true) {
            
        }
    }
}
