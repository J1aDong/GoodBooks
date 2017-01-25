//
//  pushViewController.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/1/24.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit

class pushViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
        
        self.setNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setNavigationBar() {
        let navigationView = UIView(frame: CGRect(x: 0, y: -20, width: SCREEN_WIDTH, height: 65))
        navigationView.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.addSubview(navigationView)

        let addBookBtn = UIButton(frame: CGRect(x: 20, y: 20, width: SCREEN_HEIGHT, height: 45))
        addBookBtn.setImage(UIImage(named: "plus circle"), for: .normal)
        addBookBtn.setTitleColor(UIColor.black, for: .normal)
        addBookBtn.setTitle(" 新建书评", for: .normal)
//        addBookBtn.titleLabel?.font = UIFont(name: <#T##String#>, size: 15)
    }

}
