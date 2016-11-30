//
//  LJ_AmuseViewController.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/26.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit



class LJ_AmuseViewController: BaseAnchorViewController {

    // MARK : - 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
}
// MARK : - 请求数据
extension LJ_AmuseViewController {
    override func loadData() {
        // 1.给父类中的ViewModel进行赋值
        baseVM = amuseVM
        // 3.请求数据
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}











