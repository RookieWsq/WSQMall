//
//  WSQBaseNavigationController.swift
//  WSQMall
//
//  Created by 翁胜琼 on 2017/12/17.
//  Copyright © 2017年 John. All rights reserved.
//

import UIKit

class WSQBaseNavigationController: UINavigationController {

    override func loadView() {
//        setupNavigationBar()
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count >= 1
        {
            let fixedSpaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            fixedSpaceItem.width = -20
        
            let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 33, height: 33))
            backButton.setImage(#imageLiteral(resourceName: "navigation_back_normal").withRenderingMode(.alwaysOriginal), for: .normal)
            backButton.setImage(#imageLiteral(resourceName: "navigation_back_hl"), for: .highlighted)
            backButton.addTarget(self, action: #selector(popToParent), for: .touchUpInside)
            
            let backBarButtonItem = UIBarButtonItem(customView: backButton)
            
            viewController.navigationItem.leftBarButtonItems = [backBarButtonItem]
            viewController.hidesBottomBarWhenPushed = true
            // 开启滑动返回
            self.interactivePopGestureRecognizer?.delegate = nil
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    private func setupNavigationBar()
    {
        let bar = UINavigationBar.appearance()
        bar.backgroundColor = mainColor
        bar.shadowImage = UIImage()
        bar.tintColor = .clear
        
        var dic = [NSAttributedStringKey:Any]()
        dic[NSAttributedStringKey.foregroundColor] = UIColor.black
        dic[NSAttributedStringKey.font] = UIFont.systemFont(ofSize: 18)
        bar.titleTextAttributes = dic
        
        setValue(bar, forKey: "NavigationBar")
    }
    @objc private func popToParent()
    {
        popViewController(animated: true)
    }
}
