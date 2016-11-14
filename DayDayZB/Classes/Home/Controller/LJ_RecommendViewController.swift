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

class LJ_RecommendViewController: UIViewController {
    //MARK : - 懒加载属性
    fileprivate lazy var recommendVM : ReccommendViewModel = ReccommendViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
       // 创建布局
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width : kItemW, height : kNormalItemH)
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMagin
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMagin, 0, kItemMagin)
        layout.headerReferenceSize = CGSize(width : kScreenW, height : kHeaderViewH)
        
        // 创建UICollectionView
        let collectionView = UICollectionView(frame : self.view.bounds, collectionViewLayout : layout)
        
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)

       collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
       
        return collectionView
        
    }()
    
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
    fileprivate func loadData() {
        
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
    fileprivate func setupUI() {
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

// MRAK: - 遵守UICOllectionViewDataSource的数据源协议
extension LJ_RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        
        return group.anchors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        
        // 定义cell
        
        
        // 取出cell
        if indexPath.section == 1 {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionViewPrettyCell
            cell.anchor = anchor
            return cell
        } else {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
            cell.anchor = anchor
            return cell
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 取出sectionHeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        // 取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section]

        
        return headerView
    }
    

}

