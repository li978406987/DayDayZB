//
//  PageContentView.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/4.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}
fileprivate let contentViewId = "contentViewId"
class PageContentView: UIView {

    // MARk: - 懒加载属性(闭包) (为避免循环引用 需要用weak)
    fileprivate lazy var collectionview : UICollectionView = {[weak self] in
       // 创建layout
        let layout = UICollectionViewFlowLayout()
        // 把self变成可选类型(可选链)  (self?.bounds.size)! 是强制进行解包
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentViewId)

        return collectionView
    }()
    
    // MARk: - 定义属性
    fileprivate var childVcs : [UIViewController]
    //弱引用加weak (需要在UIViewController后面加问号 表示可选类型)
    fileprivate weak var parentViewController : UIViewController?
    
    fileprivate var startOffSetX : CGFloat = 0
    
    fileprivate var isForbidScrollDelegate : Bool = false
    
    weak var delegate : PageContentViewDelegate?
    
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController?) {
        self.childVcs = childVcs
        // 可选类型  赋值给可选类型
        self.parentViewController = parentViewController
        super.init(frame : frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

 // MARK: - 设置UI界面
extension PageContentView {
    
    fileprivate func setupUI() {
        // 将所有自控制器加到子控制器中
        
        for childVc in childVcs {
            // parentViewController后面也要加问号表示可选链
            parentViewController?.addChildViewController(childVc)
        }
        
        // 添加一个uicollectionView用于在cell中存放控制器的View
        addSubview(collectionview)
        collectionview.frame = bounds
    }
}
// Mark  : - 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentViewId, for: indexPath)
        // 给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }

}

// Mark  : - 遵守UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffSetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 0. 判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        // 1.获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //判断滑动的方向
        let currentOffSetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffSetX > startOffSetX { // 左滑
            // 1.计算progress
            // floor()  取整函数
            progress = currentOffSetX / scrollViewW - floor(currentOffSetX / scrollViewW)
            // 2.计算sourceIndex
            sourceIndex = Int(currentOffSetX / scrollViewW)
            
            // 3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            // 4.如果完全滑过去
            if currentOffSetX - startOffSetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
            
        } else { // 右滑
           // 计算Progress
            progress = 1 - (currentOffSetX / scrollViewW - floor(currentOffSetX / scrollViewW))
            
            // 计算targetIndex
            targetIndex = Int(currentOffSetX / scrollViewW)
            
            //计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex > childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            
        }
        
        // 将progress/ sourceIndex/ targetIndex 传递给titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    
}


// MARK : - 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        // 记录需要执行的代理方法
        isForbidScrollDelegate = true
        
        // 滚动正确的位置
        let offSetX = CGFloat(currentIndex) * collectionview.frame.width
        collectionview.setContentOffset(CGPoint(x: offSetX, y: 0), animated: false)
        
}

}


