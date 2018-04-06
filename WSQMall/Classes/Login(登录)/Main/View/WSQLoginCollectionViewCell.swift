//
//  WSQLoginCollectionViewCell.swift
//  WSQMall
//
//  Created by 翁胜琼 on 2018/4/2.
//  Copyright © 2018年 John. All rights reserved.
//

import UIKit

class WSQLoginCollectionViewCell: UICollectionViewCell {
    var contentSubView : UIView!
    {
        didSet
        {
            for subView in self.subviews {
                subView.removeFromSuperview()
            }
            self.addSubview(contentSubView)
            contentSubView.snp.makeConstraints { (maker) in
                maker.top.left.bottom.right.equalToSuperview()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
