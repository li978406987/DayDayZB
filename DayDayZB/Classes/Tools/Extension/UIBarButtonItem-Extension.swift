//
//  UIBarButtonItem-Extension.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/3.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    /*
    class func createItem(imageName : String, highImageName : String, size : CGSize) -> UIBarButtonItem {
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named : imageName), for: .normal)
        btn.setImage(UIImage(named : highImageName), for: .highlighted)
        
        btn.frame = CGRect(origin : CGPoint.zero, size : size)
        
        return UIBarButtonItem(customView: btn)
    }
    */
    // 便利构造函数: 1>convenience开头 2>在构造函数中必须明确调用一个设计的构造函数(self)
   
    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSize.zero) {
        //创建UIButton
        let btn = UIButton()
        //设置button的图片
        btn.setImage(UIImage(named : imageName), for: .normal)
        if highImageName != "" {
        btn.setImage(UIImage(named : highImageName), for: .highlighted)
        }
        //设置尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin : CGPoint.zero, size : size)
            
        }
        // 在构造函数中必须明确调用一个设计的构造函数(self)
        //创建UIBArButtonItem
        self.init(customView: btn)

    }
    
    
}
