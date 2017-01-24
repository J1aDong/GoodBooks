//
//  ViewController.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/1/24.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit
import LeanCloud

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let post = LCObject(className: "TestObject")
        post.set("words", value: "Hello swift")
        post.save()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

