//
//  LJ_HomeViewController.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/3.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class LJ_HomeViewController: UIViewController {
    //MARK: - 懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: Int(kStatusBarH + kNavigationBarH), width: Int(kScreenW), height: Int(kTitleViewH))
        
        
        let titles = ["推荐", "游戏", "娱乐", "手游","趣玩"]
        
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
        
    }()
    
    
    


    fileprivate lazy var pageContenView : PageContentView = {[weak self] in
        //确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width:kScreenW, height:contentH)
        //确定所有的子控制器
        var chileVcs = [UIViewController]()
        chileVcs.append(LJ_RecommendViewController())
        chileVcs.append(LJ_GameViewController())
        chileVcs.append(LJ_AmuseViewController())
        for _ in 0..<2 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            chileVcs.append(vc)
        }
        
        
        
        let contentView = PageContentView(frame: contentFrame, childVcs : chileVcs, parentViewController : self)
        
        contentView.delegate = self
        return contentView
    }()
   
    
    
    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }

}

extension LJ_HomeViewController {
    //MARK: - 设置UI界面
    fileprivate func setupUI() {
        
        automaticallyAdjustsScrollViewInsets = false
        
        //设置左侧的Item
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName : "logo")
        
        //设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "image_my_history_click", size: size)
        //        let historyItem = UIBarButtonItem.createItem(imageName: "image_my_history", highImageName: "image_my_history_click", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        //        let searchItem = UIBarButtonItem.createItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        //        let qrcodeItem = UIBarButtonItem.createItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem];
        
        //添加TitleView
        view.addSubview(pageTitleView)
        
        //添加ContentView
        view.addSubview(pageContenView)
        pageContenView.backgroundColor = UIColor.purple
        
    }

}

extension LJ_HomeViewController : PageTitleViewDelegate {
    
    // MARK : - 遵守PageTitleViewDelegate协议
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int) {
        pageContenView.setCurrentIndex(currentIndex: index)
        
    }

}


extension LJ_HomeViewController : PageContentViewDelegate {
    // MARK : - 遵守PageContentViewDelegate协议
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


