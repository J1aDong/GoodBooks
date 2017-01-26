//
//  pushNewBookViewController.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/1/25.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit

class pushNewBookViewController: UIViewController,BookTitleDelegate {
    
    var bookTitle:BookTitle?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.bookTitle = BookTitle(frame: CGRect(x: 0, y: 40, width: SCREEN_WIDTH, height: 160))
        self.bookTitle?.delegate = self
        self.view.addSubview(self.bookTitle!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func choiceCover() {
        print("choiceCover")
    }
    
    override func cancel(){
        super.cancel()
        self.dismiss(animated: true) { 
            
        }
    }

}
