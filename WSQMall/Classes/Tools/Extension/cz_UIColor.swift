//
//  cz_UIColor.swift
//  Project1
//
//  Created by imac on 2017/6/5.
//  Copyright © 2017年 iimac. All rights reserved.
//

import UIKit

extension UIColor{
    
    // 十六位设置颜色
    static func cz_hex(hex : UInt32) -> UIColor{
        
        let r = CGFloat((hex & 0xff0000) >> 16)
        let g = CGFloat((hex & 0x00ff00) >> 8)
        let b = CGFloat(hex & 0x0000ff)
        
        return UIColor.cz_RGB(red: r, green: g, blue: b)
        
    }
    // 使用RGB创建颜色
    static func cz_RGB(red : CGFloat , green : CGFloat , blue : CGFloat , alpha : CGFloat = 1) -> UIColor{
        let color = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:alpha)
        return color
    }
    // 随机颜色
    static func cz_random() -> UIColor{
        return cz_RGB(red: CGFloat(arc4random_uniform(255))+1, green: CGFloat(arc4random_uniform(255))+1, blue: CGFloat(arc4random_uniform(255))+1)
    }
    
}



