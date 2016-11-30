//
//  LJ_GameViewController.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/14.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

private let kEdgMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5

private let kGameCelID = "kGameCelID"

class LJ_GameViewController: UIViewController {

    // MARK: - 懒加载属性
    fileprivate lazy var gameVm : GameViewModel = GameViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgMargin, bottom: 0, right: kEdgMargin)
        
        let collectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCelID)
        collectionView.dataSource = self
        
        return collectionView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
}

// MARK : - 设置UI界面
extension LJ_GameViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}


// MARk : - 请求数据
extension LJ_GameViewController {
    fileprivate func loadData() {
        gameVm.loadAllGameData {
            self.collectionView.reloadData()
        }
    }
}


// MARK : - 遵守UICOllectionView的数据源协议
extension LJ_GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return gameVm.games.count
        }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            // 1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCelID, for: indexPath) as! CollectionViewGameCell
       
        let gameModel = gameVm.games[indexPath.item]
        cell.baseGame = gameModel
            return cell
        }
   
}




