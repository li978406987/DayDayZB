//
//  RecommendCycleView.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/11.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

fileprivate let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {

    

    // Mrak: - 控件属性
    @IBOutlet var colllectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    
    // Mark: - 定义属性
    var cycleTimer : Timer?
    
    var cycleModels : [CycleModel]? {
        didSet {
            // 1.刷新collectionView
            colllectionView.reloadData()
            
            // 2.设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            // 3.默认滚动中间的某一位置
            let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            colllectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            // 4.添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }

    
    //Mark : - 系统回调
    override func awakeFromNib() {
        // 这是该控间不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        // 注册cell
       colllectionView.register(UINib(nibName: "CollectionViewCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置collectionView的layout
        let layout = colllectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = colllectionView.bounds.size
        
    }

}



// Mark : - 提供一个快速创建View的类方法
extension RecommendCycleView {
    class func recommendcycleView() -> RecommendCycleView {
        
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as!RecommendCycleView
        
        
    }
}

// MARK: - 遵守connectionView的数据源协议
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionViewCycleCell
        
        cell.cycleModel = cycleModels?[indexPath.item % cycleModels!.count]
 
        return cell
        
    }
}

// Mark: - 遵守UICollectionView的代理协议
extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 1.获取滚动的偏移量
        let offSetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 2. 计算pageControl的currentIndex
        pageControl.currentPage = Int(offSetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        addCycleTimer()
        
    }
    
}

// Mark : - 定时器的做操方法
extension RecommendCycleView {
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    
    fileprivate func removeCycleTimer() {
        cycleTimer?.invalidate()  // 从运行循环中移除
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        // 1.获取滚动的偏移量
        let currentOffSetX = colllectionView.contentOffset.x
        let offSetX = currentOffSetX + colllectionView.bounds.width
        // 2.滚动到该位置
        colllectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: true)
        
    }
}




