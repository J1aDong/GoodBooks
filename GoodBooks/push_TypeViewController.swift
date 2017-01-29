//
//  push_TypeViewController.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/1/29.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit

class push_TypeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func cancel(){
        super.cancel()
        self.dismiss(animated: true) {

        }
    }

}
