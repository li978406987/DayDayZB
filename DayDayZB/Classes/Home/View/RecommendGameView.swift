//
//  RecommendGameView.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/13.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

fileprivate let kGameCellId = "kGameCellId"

fileprivate let kEdgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {
    
    
    // Mark : - 定义数据的属性
    var groups : [AnchorGroup]? {
        didSet {
            // 移除前两组的数据
            groups?.removeFirst()
            groups?.removeFirst()
            // 添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            collectionview.reloadData()
        }
    }
    
    // MArk: - 控件属性
    @IBOutlet var collectionview: UICollectionView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // 让空间不能随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
    
        // 注册cell
    
        collectionview.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellId)
        
        // 给collectionView添加内边距
        collectionview.contentInset = UIEdgeInsets(top:0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)

        }
}

// MArk: - 提供快速创建的列方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options:nil)!.first as! RecommendGameView
    }
}

// Mark : - 遵守UICollectionView的数据源协议
extension RecommendGameView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellId, for: indexPath) as! CollectionViewGameCell
        cell.baseGame = groups![indexPath.item]

            return cell
        
    }
    
}







