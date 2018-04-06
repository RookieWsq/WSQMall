//
//  WSQProfileViewController.swift
//  WSQMall
//
//  Created by 翁胜琼 on 2017/12/17.
//  Copyright © 2017年 John. All rights reserved.
//

import UIKit

class WSQProfileViewController: WSQBaseSetViewController {

    var hud : MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navRightItem = UIBarButtonItem(title: "退出", style: .plain, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = navRightItem
        // Do any additional setup after loading the view.
    }

    @objc private func logout()
    {
        self.hud = MBProgressHUD.showAdded(to: (self.navigationController?.view)!, animated: true)
        self.view.endEditing(true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            [unowned self] in
            MallObjManager.removeUserData("isLogin")
            self.hud.hide(animated: true)
            self.hud.label.text = "登出成功"
            self.hud.hide(animated: true, afterDelay: 1)
            
            let loginVC = WSQLoginTableViewController()
            let nav = UINavigationController(rootViewController: loginVC)
            self.present(nav, animated: true, completion: nil)

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
