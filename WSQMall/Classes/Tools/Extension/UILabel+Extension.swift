//
//  UILabel+Extension.swift
//  WSQMall
//
//  Created by 翁胜琼 on 2018/4/7.
//  Copyright © 2018年 John. All rights reserved.
//

import Foundation
import UIKit

extension UILabel
{
    convenience init(frame : CGRect = CGRect.zero , text : String , fontSize : CGFloat ,textColor : UIColor = UIColor.darkText , textAlignment : NSTextAlignment = .left)
    {
        self.init(frame: frame)
        self.text = text
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textAlignment = textAlignment
    }
}
