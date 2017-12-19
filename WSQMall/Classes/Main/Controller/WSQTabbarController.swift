//
//  WSQTabbarController.swift
//  WSQMall
//
//  Created by 翁胜琼 on 2017/12/17.
//  Copyright © 2017年 John. All rights reserved.
//

import UIKit

class WSQTabbarController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupUI()
        
    }
    
}
// MARK: - SetupUI
extension WSQTabbarController{
    func setupUI(){
        setupTabBar()
        addchildVC()
    }
    func setupTabBar()
    {
        let tabBar = WSQBaseTabBar()
        tabBar.backgroundColor = .white
        setValue(tabBar, forKey: "tabBar")
    }
    func addchildVC(){
        let childVCArray = [
            ["ClassName":"WSQHandPickViewController",
             "Title":"首页",
             "TabImageName":"tabr_02_up",
             "TabSelImageName":"tabr_02_down"
            ],
            ["ClassName":"WSQMediaListViewController",
             "Title":"美媒榜",
             "TabImageName":"tabr_03_up",
             "TabSelImageName":"tabr_03_down"
            ],
            ["ClassName":"WSQBeautyShopViewController",
             "Title":"美店",
             "TabImageName":"tabr_04_up",
             "TabSelImageName":"tabr_04_down"
            ],
            ["ClassName":"WSQProfileViewController",
             "Title":"我的",
             "TabImageName":"tabr_05_up",
             "TabSelImageName":"tabr_05_down"
            ]
        ]
        for dic in childVCArray {
            print(dic)
            let className = NSClassFromString(Bundle.main.nameSpace+"."+dic["ClassName"]!) as! UIViewController.Type
            let vc = className.init()
            vc.view.backgroundColor = UIColor.cz_random()
            vc.navigationItem.title = dic["Title"]
            
            let nav = WSQBaseNavigationController(rootViewController: vc)
            self.addChildViewController(nav)
            
            let normalImage = UIImage(named: dic["TabImageName"] ?? "")?.withRenderingMode(.alwaysOriginal)
            let selImage = UIImage(named: dic["TabSelImageName"] ?? "")?.withRenderingMode(.alwaysOriginal)
            nav.tabBarItem.image = normalImage
            nav.tabBarItem.selectedImage = selImage
            nav.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
            
        }
    }
}

// MARK: - TabbarControllerDelegate
extension WSQTabbarController
{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // 点击的同时添加帧动画
            tabbarButtonClick()
        
    }
    
    // FIXME: 重构一下和这个方法，这个方法循环嵌套过多
    // 获取到被点击的 tabbarButton
    func tabbarButtonClick()
    {
        let tabbarButtons = tabBar.subviews
        var buttonImageViews = [UIView]()
        for tabbarButton in tabbarButtons {
            guard let UITabbarButton = NSClassFromString("UITabBarButton"),
                let UITabBarSwappableImageView = NSClassFromString("UITabBarSwappableImageView")
            else {return }
           
            if tabbarButton.isKind(of: UITabbarButton)
            {
                for subView in tabbarButton.subviews
                {
                    if subView.isKind(of: UITabBarSwappableImageView)
                    {
                        // 保存 imageView
                        buttonImageViews.append(subView)
                    }
                }
            }
        }
        // 为点击的 imageView 设置帧动画
        addCAKeyFrameAnimation(at: buttonImageViews[selectedIndex])
    }
    
    // 添加帧动画
    func addCAKeyFrameAnimation(at view : UIView)
    {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform.scale"
        animation.values = [1.1,1.0,0.9,1.0]
        animation.repeatCount = 1
        animation.duration = 0.3
        animation.calculationMode = kCAAnimationCubic
        
        view.layer.add(animation, forKey: nil)
    }
    // 设置 tabbarController 的视图和其子视图的旋转方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return .portrait
    }
    // 你跳转（present）到这个新控制器时，按照什么方向初始化控制器
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation
    {
        return .portrait
    }
}
