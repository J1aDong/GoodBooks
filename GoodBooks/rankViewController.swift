//
//  rankViewController.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/1/24.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit
import AVOSCloud

class rankViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        if  AVUser.current() == nil{
            let story = UIStoryboard(name: "Login", bundle: nil)
            let loginVC = story.instantiateViewController(withIdentifier: "Login")
            self.present(loginVC, animated: true, completion: { 
                
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
