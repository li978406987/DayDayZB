//
//  AnchorModel.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/10.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {

    // 房间ID
    var room_id : Int = 0
    // 房间图片对应的URL string
    var  vertical_src : String = ""
    
    //判断是手机直播还是电脑直播
    // 0手机直播  1电脑直播
    var isVertical : Int = 0
    // 房间名字
    var room_name : String = ""
    // 主播名称
    var nickname : String = ""
    // 房间人数
    var online : Int = 0
    
    // 所在城市
    var anchor_city : String = ""
    
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
