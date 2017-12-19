//
//  WSQHandPickViewController.swift
//  WSQMall
//
//  Created by 翁胜琼 on 2017/12/17.
//  Copyright © 2017年 John. All rights reserved.
//

import UIKit

class WSQHandPickViewController: WSQBaseSetViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style:.plain, target: self, action: #selector(push))
    }
    @objc func push()
    {
        let vc = WSQBaseSetViewController()
        vc.view.backgroundColor = .cz_random()
        navigationController?.pushViewController(vc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
