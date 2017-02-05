//
//  pushBook_Cell.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/2/2.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit
import SWTableViewCell

class pushBook_Cell: SWTableViewCell {
    
    var bookName:UILabel?
    var editor:UILabel?
    var more:UILabel?
    
    var cover:UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for view in self.contentView.subviews{
            view.removeFromSuperview()
        }
        
        self.bookName = UILabel(frame: CGRect(x: 78, y: 8, width: 242, height: 25))
        self.editor = UILabel(frame: CGRect(x: 78, y: 33, width: 242, height: 25))
        self.more = UILabel(frame: CGRect(x: 78, y: 66, width: 242, height: 25))
        
        self.bookName?.font = UIFont(name: MY_FONT, size: 15)
        self.editor?.font = UIFont(name: MY_FONT, size: 15)
        self.more?.font = UIFont(name: MY_FONT, size: 13)
        self.more?.textColor = UIColor.gray
        
        self.contentView.addSubview(self.bookName!)
        self.contentView.addSubview(self.editor!)
        self.contentView.addSubview(self.more!)
        
        self.cover = UIImageView(frame: CGRect(x: 8, y: 9, width: 56, height: 70))
        self.contentView.addSubview(self.cover!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
