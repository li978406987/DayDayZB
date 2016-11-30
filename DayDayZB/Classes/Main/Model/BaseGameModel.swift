//
//  BaseGameModel.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/26.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {

    // MARK : - 定义属性
    var tag_name : String = ""
    
    var icon_url : String = ""
    // Mark : - 构造函数
    override init() {
        
    }
    
    // MARK : - 自定义构造函数
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
