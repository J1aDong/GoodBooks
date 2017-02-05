//
//  bookDetailView.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/2/2.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit

class bookDetailView: UIView {
    var VIEW_WIDTH:CGFloat?
    var VIEW_HEIGHT:CGFloat?
    
    var bookName:UILabel?
    var editor:UILabel?
    var userName:UILabel?
    var date:UILabel?
    var more:UILabel?
    var scroe:LDXScore?
    
    var cover:UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.VIEW_WIDTH = frame.size.width
        self.VIEW_HEIGHT = frame.size.height
        self.backgroundColor = UIColor.white
        
        self.cover = UIImageView(frame: CGRect(x: 8, y: 8, width: (VIEW_HEIGHT!-16)/1.273, height: VIEW_HEIGHT!-16))
        self.addSubview(self.cover!)
        
        self.bookName = UILabel(frame: CGRect(x: (VIEW_HEIGHT!-16)/1.273+16, y: 8, width: VIEW_WIDTH! - (VIEW_HEIGHT! - 16)/1.273-16, height: VIEW_HEIGHT!/4))
        self.bookName?.font = UIFont(name: MY_FONT, size: 18)
        self.addSubview(self.bookName!)
        
        self.editor = UILabel(frame: CGRect(x: (VIEW_HEIGHT!-16)/1.273+16, y: 8+VIEW_HEIGHT!/4, width: VIEW_WIDTH! - (VIEW_HEIGHT! - 16)/1.273-16, height: VIEW_HEIGHT!/4))
        self.editor?.font = UIFont(name: MY_FONT, size: 18)
        self.addSubview(self.editor!)
        
        self.userName = UILabel(frame: CGRect(x:(VIEW_HEIGHT!-16)/1.273+16,y:24+VIEW_HEIGHT!/4+VIEW_HEIGHT!/6,width:VIEW_WIDTH!-(VIEW_HEIGHT! - 16)/1.273-16,height:VIEW_HEIGHT!/6))
        self.userName?.font = UIFont(name: MY_FONT, size: 13)
        self.userName?.textColor = RGB(r: 35, g: 87, b: 13)
        self.addSubview(self.userName!)
        
        self.date = UILabel(frame: CGRect(x: (VIEW_HEIGHT!-16)/1.273+16, y: 16+VIEW_HEIGHT!/4+VIEW_HEIGHT!/6*2, width: 80, height: VIEW_HEIGHT!/6))
        self.date?.textColor = UIColor.gray
        self.date?.font = UIFont(name: MY_FONT, size: 13)
        self.addSubview(self.date!)
        
        self.scroe = LDXScore(frame: CGRect(x: (VIEW_HEIGHT!-16)/1.273+16+80, y: 16+VIEW_HEIGHT!/4+VIEW_HEIGHT!/6*2, width: 80, height: VIEW_HEIGHT!/6))
        self.scroe?.isSelect = false
        self.scroe?.normalImg = UIImage(named: "btn_star_evaluation_normal")
        self.scroe?.highlightImg = UIImage(named: "btn_star_evaluation_press")
        self.scroe?.max_star = 5
        self.scroe?.show_star = 5
        self.addSubview(self.scroe!)
        
        self.more = UILabel(frame: CGRect(x:(VIEW_HEIGHT!-16)/1.273+16,y:8+VIEW_HEIGHT!/4+VIEW_HEIGHT!/6*3,width:VIEW_WIDTH!-(VIEW_HEIGHT! - 16)/1.273-16,height:VIEW_HEIGHT!/6))
        self.more?.textColor = UIColor.gray
        self.more?.font = UIFont(name: MY_FONT, size: 13)
        self.addSubview(self.more!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(0.5)
        context?.setStrokeColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
        context?.move(to: CGPoint(x: 8, y: VIEW_HEIGHT!-2))
        context?.addLine(to: CGPoint(x: VIEW_WIDTH! - 8, y: VIEW_HEIGHT! - 2))
        context?.strokePath()
    }

}
