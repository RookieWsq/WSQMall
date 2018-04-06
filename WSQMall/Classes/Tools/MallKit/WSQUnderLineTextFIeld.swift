//
//  WSQUnderLineTextFIeld.swift
//  WSQMall
//
//  Created by 翁胜琼 on 2018/4/2.
//  Copyright © 2018年 John. All rights reserved.
//

import UIKit

class WSQUnderLineTextFIeld: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderStyle = .none
        self.leftViewMode = .always
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return  }
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y:rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: frame.maxY))
        
        context.setLineWidth(0.5)
        context.setStrokeColor(WSQGrayColor.withAlphaComponent(0.45).cgColor)
        context.addPath(path.cgPath)
        
        context.strokePath()
    }
    
    // leftView的frame 设置
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var oldBounds = super.leftViewRect(forBounds: bounds)
        oldBounds.size.width = 13
        oldBounds.size.height = 13
        oldBounds.origin.x = 8
        
        return oldBounds
    }
    // 设置普通状态下 textRect
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var oldBounds = super.textRect(forBounds: bounds)
        oldBounds.origin.x = 28
        
        return oldBounds
    }
    // 设置编辑状态下 textRect
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var oldBounds = super.editingRect(forBounds: bounds)
        oldBounds.origin.x = 28
        
        return oldBounds
    }

}
