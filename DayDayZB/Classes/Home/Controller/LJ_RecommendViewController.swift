//
//  LJ_RecommendViewController.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/4.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit
import Alamofire

fileprivate let kItemMagin : CGFloat = 10
fileprivate let kItemW = (kScreenW - 3 * kItemMagin) / 2
fileprivate let kNormalItemH = kItemW * 3 / 4
fileprivate let kPrettyItemH = kItemW
fileprivate let kHeaderViewH : CGFloat = 50

fileprivate let kCycleViewH = kScreenW * 3 / 8

fileprivate let kGameViewH : CGFloat = 90

fileprivate let kNormalCellID = "kNormalCellID"
fileprivate let kPrettyCellID = "kPrettyCellID"
fileprivate let kHeaderViewID = "HeaderViewID"

class LJ_RecommendViewController: BaseAnchorViewController {
    //MARK : - 懒加载属性
    fileprivate lazy var recommendVM : ReccommendViewModel = ReccommendViewModel()
    
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendcycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height:kCycleViewH)
        
        return cycleView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x:0, y:-kGameViewH, width:kScreenW, height:kGameViewH)
        return gameView
    }()
    
    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置UI界面
        setupUI()
        
        // 发送网络请求
        loadData()
    
    }
}

// Mark : - 请求数据

extension LJ_RecommendViewController {
    override func loadData() {
        // 0.给父类中的ViewModekl进行赋值
        baseVM = recommendVM
        
        // 1.请求推荐数据
        recommendVM.requestData {
            // 展示推荐数据
            self.collectionView.reloadData()
            
            // 将数据传递给GameView
            self.gameView.groups = self.recommendVM.anchorGroups
            
            
        }
        // 2.请求轮播数据
        recommendVM.requestCycleData {
           self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
        
        
    }
}


// Mark : - 设置UI界面
extension LJ_RecommendViewController {
    override func setupUI() {
        
        // 0.先调用super.setupUI()
        super.setupUI()
        
        // 1.将collectionView添加到控制器的View上
        view.addSubview(collectionView)
        // 2.将cyclyView添加到collectionView
        collectionView.addSubview(cycleView)
        
        // 3.将gameView添加带collectionView中
        collectionView.addSubview(gameView)
        
        // 4.设置collectionView的内边框
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0, 0, 0)
        
        
    }
    
}

