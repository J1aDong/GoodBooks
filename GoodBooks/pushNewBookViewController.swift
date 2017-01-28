//
//  pushNewBookViewController.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/1/25.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit

class pushNewBookViewController: UIViewController,BookTitleDelegate,PhotoPickerDelegate,VPImageCropperDelegate {
    
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

}
