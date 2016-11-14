//
//  PageTitleView.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/3.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

// 设置代理
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}
// 定义常量
fileprivate let kScrollLine : CGFloat = 2
//元组
fileprivate let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
fileprivate let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleView: UIView {

    // MARK: - 定义属性
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String]
    // 代理最好用weak
    weak var delegate : PageTitleViewDelegate?
    
    // MARK: - 懒加载属性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView : UIScrollView = {
    
        let scrollView = UIScrollView()
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.isPagingEnabled = false
        return scrollView
        
    
    }()
    
    fileprivate lazy var scrollLine : UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
    }()
    
    // MARK: -自定义构造函数
    init(frame: CGRect, titles : [String]) {
        self.titles = titles;
        
        super.init(frame : frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension PageTitleView {
    // 设置UI界面
    fileprivate func setupUI() {
        // 添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        // 添加title对应的Label
        setupTitleLabels()
        //设置底线和滚动的滑块
        setupBottonLineAndScrollLine()
    }
    
    fileprivate func setupTitleLabels() {
        
        // 确定label的frame的值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLine
        
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //创建label
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 20.0)
            label.textColor = UIColor(r:kNormalColor.0, g:kNormalColor.1, b : kNormalColor.2)
            label.textAlignment = .center
            
            // 设置Label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width:labelW, height: labelH)
            
            // 将label添加到ScrollView
            scrollView.addSubview(label)
            
            titleLabels.append(label)
            
            // 给Label 添加手势
            
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
            
            
        }
        
    }
    
    fileprivate func setupBottonLineAndScrollLine() {
        
        let  bottonLine = UIView()
        
        bottonLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottonLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        
        addSubview(bottonLine)
        
        // 添加scrollLine
        // 获取第一个Label
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor(r:kSelectColor.0, g:kSelectColor.1, b : kSelectColor.2)
        // 设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y:frame.height - kScrollLine, width: firstLabel.frame.size.width, height: kScrollLine)
        
    }
}


extension PageTitleView {
    // 对事件进行监听 @objc
    @objc fileprivate func titleLabelClick(tapGes : UITapGestureRecognizer) {
        
        // 0.获取当前Label的下标
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        // 1.如果冲入点击同一个title, 那么直接返回
        if currentLabel.tag == currentIndex { return }
        
        // 2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        // 3.切换文字的颜色
        currentLabel.textColor = UIColor(r:kSelectColor.0, g:kSelectColor.1, b : kSelectColor.2)
        oldLabel.textColor = UIColor(r:kNormalColor.0, g:kNormalColor.1, b : kNormalColor.2)
        
        // 4.保存最新label的下标
        currentIndex = currentLabel.tag
        
        // 5. 滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 6.通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
    }
 
}



// MARK : - 对外暴露的方法
extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        // 1.取出sourceLabel/ targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        
        let moveX = moveTotalX * progress
        
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 颜色的渐变 (复杂)  
        // .1取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // .2变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // .3 变化的targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4.记录 最新的index
        
        currentIndex = targetIndex
        
    }
    
}


