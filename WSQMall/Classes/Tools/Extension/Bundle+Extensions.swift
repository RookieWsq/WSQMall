//
//  Bundle+Extensions.swift
//  WSQMall
//
//  Created by 翁胜琼 on 2017/12/17.
//  Copyright © 2017年 John. All rights reserved.
//

import Foundation


extension Bundle{
    var nameSpace : String{
        return infoDictionary!["CFBundleName"] as? String ?? ""
    }
}


