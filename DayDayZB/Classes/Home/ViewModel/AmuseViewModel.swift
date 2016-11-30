//
//  AmuseViewModel.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/26.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel {


    
}


extension AmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        
      loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
