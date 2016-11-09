
//
//  UIColor - Extension.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/4.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r : CGFloat, g : CGFloat, b: CGFloat) {
        self.init(red : r / 255.0, green : g / 255.0, blue : b / 255.0, alpha : 1.0)
    }
    
}
