//
//  BookTitle.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/1/26.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

@objc protocol BookTitleDelegate{
    @objc optional func choiceCover()
}

class BookTitle: UIView {

    var bookCover:UIButton?
    
    var bookName:JVFloatLabeledTextField?
    
    var bookEditor:JVFloatLabeledTextField?
    
    var delegate:BookTitleDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.bookCover = UIButton(frame: CGRect(x: 10, y: 8, width: 110, height: 141))
        self.bookCover?.setImage(UIImage(named: "Cover"), for: .normal)
        self.addSubview(self.bookCover!)
        self.bookCover?.addTarget(self, action: #selector(self.choidceCover), for: .touchUpInside)
        
        self.bookName = JVFloatLabeledTextField(frame: CGRect(x: 128, y: 8+40, width: SCREEN_WIDTH-128-15, height: 30))
        self.bookEditor = JVFloatLabeledTextField(frame: CGRect(x: 128, y: 8+70+40, width: SCREEN_WIDTH-128-15, height: 30))
        
        self.bookName?.placeholder = "书名"
        self.bookEditor?.placeholder = "作者"
        
        self.bookName?.floatingLabelFont = UIFont(name: MY_FONT, size: 12)
        self.bookEditor?.floatingLabelFont = UIFont(name: MY_FONT, size: 12)
        
        self.bookName?.font = UIFont(name: MY_FONT, size: 14)
        self.bookEditor?.font = UIFont(name: MY_FONT, size: 14)
        
        self.addSubview(self.bookName!)
        self.addSubview(self.bookEditor!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func choidceCover(){
        self.delegate?.choiceCover!()
    }
}
