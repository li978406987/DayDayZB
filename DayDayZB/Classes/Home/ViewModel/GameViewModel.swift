//
//  GameViewModel.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/25.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

class GameViewModel : BaseGameModel {

    lazy var games : [GameModel] = [GameModel]()
}


extension GameViewModel {
    func loadAllGameData(finishedCallback : @escaping () -> ()) {
        NetWorkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            // 1.获取数据
            guard let resultDic = result as? [String : Any] else { return }
            guard let dataArray = resultDic["data"] as? [[String : Any]] else { return }
            
            // 2.字典转模型
            for dict in dataArray {
                self.games.append(GameModel(dict : dict as! [String : NSObject]))
           
            }
            // 3.完成回调
            finishedCallback()
        }
        
    }
    
}

