//
//  CycleModel.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/12.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    // 标题
    var title : String = ""
    
    // 展示的图片
    var pic_url : String = ""
    
    // 主播信息对应的字典
    
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else { return }
                anchor = AnchorModel(dict : room)
            
        }
    
    }
    
    // 主播信息对应的模型对象
    
    var anchor : AnchorModel?
    
    // Mark : - 自定义构造函数
    init(dict : [String : NSObject]) {
        super.init()
       
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
 
    
}
