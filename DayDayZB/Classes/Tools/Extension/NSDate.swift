//
//  NSDate.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/10.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
        
    }
}
