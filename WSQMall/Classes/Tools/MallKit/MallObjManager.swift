//
//  MallObjManager.swift
//  WSQMall
//
//  Created by 翁胜琼 on 2018/4/1.
//  Copyright © 2018年 John. All rights reserved.
//  负责数组的操作

import Foundation

/**
    *是否登录 Bool isLogin
    *用户名 String userName
 
 */

struct MallObjManager {
    
    // MARK: - 归档数据到沙盒
    static func save(_ object:Any , byFileName fileName: String)
    {
        let path = append(fileName)
        
        NSKeyedArchiver.archiveRootObject(object, toFile: path)
    }
    
    // MAKR: - 通过文件名从沙盒中获取归档的对象
    static func getObject(byFileName fileName : String) -> Any?
    {
        let path = append(fileName)
        
       return NSKeyedUnarchiver.unarchiveObject(withFile: path)
    }
    
    // MAKR: - 根据文件名删除沙盒中的 plist 文件
    static func removeFile(byFileName fileName : String)
    {
        let path = append(fileName)
        
        do
        {
            try FileManager.default.removeItem(atPath: path)
        }
        catch
        {
            print("删除 plist 出错")
        }
        
    }
    
    // MAKR: - 储存用户偏好设置
    static func saveUserData(_ data : Any? , forKey key : String)
    {
        guard let data = data else { return print("data 为 nil") }
        
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    // MAKR: - 读取用户偏好设置
    static func readUserData(_ key : String) -> Any?
    {
        return UserDefaults.standard.object(forKey: key)
    }
    
    // MAKR: - 删除用户偏好设置
    static func removeUserData(_ key : String)
    {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}

// 辅助方法
extension MallObjManager
{
    // 拼接文件路径
    private static func append(_ filePath:String) -> String
    {
        let path = NSHomeDirectory() + "/" + filePath
        
        return path
    }
}


