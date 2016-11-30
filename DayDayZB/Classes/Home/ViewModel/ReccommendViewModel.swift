//
//  ReccommendViewModel.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/10.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

class ReccommendViewModel : BaseViewModel {
    // Mark : - 懒加载属性
    lazy var anchorAll : [AnchorGroup] = [AnchorGroup]()

    lazy var cycleModels = [CycleModel]()
    
    fileprivate lazy var bigDataGroup :AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyDataGroup :AnchorGroup = AnchorGroup()
}

// Mark: - 发送网络请求
extension ReccommendViewModel {
    func requestData(finishCallBack : @escaping () -> ()) {
        
        // 创建Group
        let dGroup = DispatchGroup()
        
        // 1.请求第一部分的推荐数据
        dGroup.enter()
        NetWorkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom?client_sys=ios") { (result) in
    
            // 1.将result转成字典类型
            guard let resultDic = result as? [String : Any] else { return }
            
            // 2.根绝date该key 获取数据
            guard let dataArray = resultDic["data"] as? [[String : Any]] else { return }
            
            // 3.遍历字典 ,转成模型对象

            // 3.1 设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "columnHotIcon"
            
            // 3.2 获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict : dict)
                
                self.bigDataGroup.anchors.append(anchor)
            }
             dGroup.leave()
          
        }
       
        
        
        // 2.请求第二部分的颜值数据
        dGroup.enter()
        NetWorkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&client_sys=ios&offset=0") { (result) in
            
            // 1.将result转成字典类型
            guard let resultDic = result as? [String : Any] else { return }
            
            // 2.根绝date该key 获取数据
            guard let dataArray = resultDic["data"] as? [[String : Any]] else { return }
            
            // 3.遍历字典 ,转成模型对象
            // 3.1 设置组的属性
            self.prettyDataGroup.tag_name = "颜值"
            self.prettyDataGroup.icon_name = "columnYanzhiIcon"

            // 3.2 获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict : dict)
                
                self.prettyDataGroup.anchors.append(anchor)
            }
            //  离开组
             dGroup.leave()
            
        }
       
        
        // 3.请求后面部分的游戏数据
        dGroup.enter()
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate?aid=ios&client_sys=ios&time=1478688180&auth=3c532e2588a3570bfd59a2a41a1c279a") {
        
            dGroup.leave()
           
        }
          // 6.所有的数据都请求到,之后排序
        dGroup.notify(queue: DispatchQueue.main) {
          
            self.anchorGroups.insert(self.prettyDataGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallBack()
        }
        
    }
    
    // 请求无限轮播的数据
    func requestCycleData(finishCallBack : @escaping () -> ()) {
        
        NetWorkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/slide/6?version=2.401&client_sys=ios") { (result) in
            
            // 1.将result转成字典类型
            guard let resultDic = result as? [String : Any] else { return }
            
            // 2.根绝date该key 获取数据
            guard let dataArray = resultDic["data"] as? [[String : Any]] else { return }
            
            // 3.遍历字典 ,转成模型对象
            
            // 3.2 获取主播数据
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict : dict as! [String : NSObject]))
            }
           
            finishCallBack()
    }

       
    }
}



