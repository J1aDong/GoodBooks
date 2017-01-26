//
//  UiUtil.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/1/25.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit

typealias closeClosure = () -> Void

class UiUtil: NSObject {

    static func addTitleWithTitle(target: UIViewController, title1: String = "关闭", title2: String = "确认") {
        let btn1 = UIButton(frame: CGRect(x: 10, y: 20, width: 40, height: 20))
        btn1.setTitle(title1, for: .normal)
        btn1.contentHorizontalAlignment = .left
        btn1.setTitleColor(MAIN_RED, for: .normal)
        btn1.titleLabel?.font = UIFont(name: MY_FONT, size: 16)
        target.view.addSubview(btn1)

        let btn2 = UIButton(frame: CGRect(x: SCREEN_WIDTH - 50, y: 20, width: 40, height: 20))
        btn2.setTitle(title2, for: .normal)
        btn2.contentHorizontalAlignment = .right
        btn2.setTitleColor(MAIN_RED, for: .normal)
        btn2.titleLabel?.font = UIFont(name: MY_FONT, size: 14)
        target.view.addSubview(btn2)

        btn1.addTarget(target, action: #selector(target.cancel), for: .touchUpInside)
        
        btn2.addTarget(target,action:#selector(target.confirm),for:.touchUpInside)
    }

}
