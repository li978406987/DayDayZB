//
//  AnchorGroup.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/10.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {

    // 该组中对应的房间 (? 表示可选)
    var room_list : [[String : Any]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict : dict))
            }
        }
    }
    
    // 该组显示的图标
    var icon_name = "home_header_normal"
    
    // 定义主播模型的数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    

 }
