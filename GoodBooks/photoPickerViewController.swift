//
//  photoPickerViewController.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/1/26.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit

protocol PhotoPickerDelegate {
    func getImageFromPicker(image:UIImage)
}

class photoPickerViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var alert:UIAlertController?
    
    var picker:UIImagePickerController?
    
    var delegate:PhotoPickerDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        
        self.view.backgroundColor = UIColor.clear
        
        self.picker = UIImagePickerController()
        // 禁止编辑
        self.picker?.allowsEditing = false
        self.picker?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(self.alert == nil){
            self.alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            self.alert?.addAction(UIAlertAction(title: "从相册选择", style: .default, handler: { (action) in
                self.localPhoto()
            }))
            self.alert?.addAction(UIAlertAction(title: "打开相机", style: .default, handler: { (action) in
                self.takePhoto()
            }))
            self.alert?.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
                self.dismiss(animated: true, completion: {
                    
                })
            }))
            self.present(self.alert!, animated: true, completion: { 
                
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- 打开相机
    private func takePhoto() {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            self.picker?.sourceType = .camera
            self.present(self.picker!, animated: true, completion: {
                
            })
        }else{
            let alertView = UIAlertController(title: "此机型无相机", message: nil, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "关闭", style: .cancel, handler: { (action) in
                self.dismiss(animated: true, completion: { 
                    
                })
            }))
            self.present(alertView, animated: true, completion: {
                
            })
        }
    }
    
    //MARK:- 打开相册
    func localPhoto() {
        self.picker?.sourceType = .photoLibrary
        self.present(self.picker!, animated: true) {
            
        }
    }
    
    //MARK:- 取消照片
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.picker?.dismiss(animated: true, completion: {
            self.dismiss(animated: true, completion: {
                
            })
        })
    }
    
    //MARK:- 确定照片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.picker?.dismiss(animated: true, completion: {
            self.dismiss(animated: true, completion: {
                self.delegate?.getImageFromPicker(image: image)
            })
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
