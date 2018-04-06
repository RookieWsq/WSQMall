//
//  UIButton+Extensions.swift
//  WSQMall
//
//  Created by 翁胜琼 on 2018/4/5.
//  Copyright © 2018年 John. All rights reserved.
//

import Foundation
import UIKit

var sq_titleLabelAlignmentKey = "sq_titleLabelAlignment"


/// 设置文字图片排列方式
///
/// - left: 文字在图片左侧
/// - bottom:  文字在图片底部
/// - top: 文字在图片顶部
/// - right: 文字在图片右侧
enum SQtitleLabelAlignment {
    case right
    case left
    case bottom
    case top
}
// MARK: - 设置文字图片排列方式
extension UIButton
{
    // 设置文字图片排列方式
    var sq_titleLabelAlignment: SQtitleLabelAlignment {
        get {
            return objc_getAssociatedObject(self, &sq_titleLabelAlignmentKey) as? SQtitleLabelAlignment ?? SQtitleLabelAlignment.right
        }
        set {
            objc_setAssociatedObject(self, &sq_titleLabelAlignmentKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            sq_settitleLabelAlignment(newValue)
        }
        
    }
    private func sq_settitleLabelAlignment(_ alignMent : SQtitleLabelAlignment)
    {
//        self.layoutIfNeeded()
        let padding : CGFloat = 12

        guard let imageViewFrame = imageView?.frame,
        let titleLabelFrame = titleLabel?.frame else
        { return  }
        
        let totalHeight = imageViewFrame.height + titleLabelFrame.height + padding
        let totalWidth = imageViewFrame.width + titleLabelFrame.width + padding
        
        switch alignMent {
        case .left:
            imageEdgeInsets  = UIEdgeInsets(top: 0
                , left: titleLabelFrame.width
                , bottom: 0
                , right: -titleLabelFrame.width
            )
            titleEdgeInsets = UIEdgeInsets(
                top: 0
                , left: -totalWidth + titleLabelFrame.width
                , bottom: 0
                , right: totalWidth - titleLabelFrame.width
            )
        case .right:
                imageEdgeInsets  = UIEdgeInsets(top: 0
                    , left: -padding
                    , bottom: 0
                    , right: 0
                )
                titleEdgeInsets = UIEdgeInsets(
                    top: 0
                    , left: 0
                    , bottom: 0
                    , right: 0
            )
        case .top:
            // FIXME: 重新完成位置适配
            imageEdgeInsets  = UIEdgeInsets(
                top: 0
                , left: titleLabelFrame.width + padding
                , bottom: -(totalHeight - imageViewFrame.height)
                , right: 0
                )
            titleEdgeInsets = UIEdgeInsets(
                top: -(totalHeight - titleLabelFrame.height)
                , left: -(totalWidth - titleLabelFrame.width*2 + padding*2)/2
                , bottom: 0
                , right: (totalWidth - titleLabelFrame.width*2 + padding*2)/2
            )
        case .bottom:
                self.imageEdgeInsets = UIEdgeInsets(
                    top: -(totalHeight - imageViewFrame.height),
                    left: 0.0,
                    bottom: 0.0,
                    right: -titleLabelFrame.width
                )
                
                self.titleEdgeInsets = UIEdgeInsets(
                    top: 0.0,
                    left: -imageViewFrame.width,
                    bottom: -(totalHeight - titleLabelFrame.height),
                    right: 0.0
                )
                
//                self.contentEdgeInsets = UIEdgeInsets(
//                    top: 0.0,
//                    left: 0.0,
//                    bottom: titleLabelFrame.height,
//                    right: 0.0
//            )
        }
    }
}

// MARK: - 快速创建按钮
extension UIButton
{
    convenience init(withFrame frame : CGRect = CGRect.zero,
                   title : String ,
                   titleColor : UIColor,
                   fontSize : CGFloat,
                   image : UIImage! = nil,
                   for state : UIControlState)
    {
        self.init(frame: frame)
        self.setTitle(title, for: state)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        self.setTitleColor(titleColor, for: state)
        self.setImage(image, for: state)
    }
    func sq_setRadius(_ cornerRadius : CGFloat ,borderColor : UIColor , borderWidth : CGFloat)
    {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}
