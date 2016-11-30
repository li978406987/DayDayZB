//
//  BaseViewModel.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/26.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

class BaseViewModel {

    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    
}

extension BaseViewModel {
    func loadAnchorData(URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        
        NetWorkTools.requestData(type: .get, URLString: URLString, parameters: parameters as! [String : NSString]?) { (result) in
            // 1.将result转成字典类型
            guard let resultDic = result as? [String : Any] else { return }
            
            // 2.根绝date该key 获取数据
            guard let dataArray = resultDic["data"] as? [[String : Any]] else { return }
            
            // 3.2 获取数据
            for dict in dataArray {
                
                self.anchorGroups.append(AnchorGroup(dict : dict as! [String : NSObject]))
                
            }
        
            
            //完成回调
            finishedCallback()
    
        }
    
    }
}
