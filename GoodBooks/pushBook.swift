//
//  pushBook.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/2/1.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit
import AVOSCloud

class pushBook: NSObject {

    static func pushBookInBack(dict:Dictionary<String, Any>,object:AVObject){
        /*
         "BooKName":(self.bookTitle?.bookName?.text)!,
         "BooKEditor":(self.bookTitle?.bookEditor?.text)!,
         "BookCover":(self.bookTitle?.bookCover?.currentImage)!,
         "title":self.book_title,
         "score":String((self.ldx_score?.show_star)!),
         "type":self.type,
         "detailType":self.detailType,
         "description":self.book_description
        */
        
        object.setObject(dict["BookName"], forKey: "BookName")
        object.setObject(dict["BookEditor"], forKey: "BookEditor")
        object.setObject(dict["title"], forKey: "title")
        object.setObject(dict["score"], forKey: "score")
        object.setObject(dict["type"], forKey: "type")
        object.setObject(dict["detailType"], forKey: "detailType")
        object.setObject(dict["description"], forKey: "description")
        object.setObject(AVUser.current(), forKey: "user")
        
        
        let image = dict["BookCover"] as? UIImage
        let coverFile = AVFile(data: UIImagePNGRepresentation(image!)!)
        
        coverFile.saveInBackground { (success, error) in
            if success{
                object.setObject(coverFile, forKey: "cover")
                object.saveInBackground({ (success, error) in
                    if success{
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushBookNotification"), object: nil, userInfo: ["success":"true"])
                    }else{
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushBookNotification"), object: nil, userInfo: ["success":"false"])
                    }
                })
            }else{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushBookNotification"), object: nil, userInfo: ["success":"false"])
            }
        }
    }
}
