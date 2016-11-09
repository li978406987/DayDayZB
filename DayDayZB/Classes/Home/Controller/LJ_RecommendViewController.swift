//
//  LJ_RecommendViewController.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/4.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

fileprivate let kItemMagin : CGFloat = 10
fileprivate let kItemW = (kScreenW - 3 * kItemMagin) / 2
fileprivate let kItemH = kItemW * 3 / 4
fileprivate let kHeaderViewH : CGFloat = 50

fileprivate let kNormalCellID = "kNormalCellID"
fileprivate let kHeaderViewID = "HeaderViewID"

class LJ_RecommendViewController: UIViewController {
    //MARK : - 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
       // 创建布局
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width : kItemW, height : kItemH)
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMagin
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMagin, 0, kItemMagin)
        layout.headerReferenceSize = CGSize(width : kScreenW, height : kHeaderViewH)
        
        // 创建UICollectionView
        let collectionView = UICollectionView(frame : self.view.bounds, collectionViewLayout : layout)
        
        collectionView.backgroundColor = UIColor.blue
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)

        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
       
        return collectionView
        
    }()
    
    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        // 设置UI界面
        setupUI()
        
    }

 
}

// Mark : - 设置UI界面
extension LJ_RecommendViewController {
    fileprivate func setupUI() {
      // 1.将collectionView添加到控制器的View上
        view.addSubview(collectionView)
        
    }
    
}

// MRAK: - 遵守UICOllectionViewDataSource的数据源协议
extension LJ_RecommendViewController : UICollectionViewDataSource {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 取出sectionHeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        
        headerView.backgroundColor = UIColor.green
        
        return headerView
    }
    

}

