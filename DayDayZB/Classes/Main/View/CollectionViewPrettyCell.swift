//
//  CollectionViewPrettyCell.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/9.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//
import UIKit
import Kingfisher

class CollectionViewPrettyCell: UICollectionViewCell {

    // Mark : - 控件属性
    
    @IBOutlet var iconImageView: UIImageView!
    
    @IBOutlet var onlineBtn: UIButton!
    
    @IBOutlet var nickNameLabel: UILabel!
    
    @IBOutlet var nickNameImageView: UIImageView!
    
    @IBOutlet var cityBtn: UIButton!
    // Mark : -定义模型属性
    var anchor : AnchorModel? {
        didSet {
            
            // 0.校验模型是否有值
            guard let anchor = anchor else {
                return
            }
            
            // 1.去除在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = String(format: "%.1f万", (Double(anchor.online) / 10000.0))
            } else {
                
                onlineStr = "\(anchor.online)"
            }
            
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            // 2.昵称的显示
            nickNameLabel.text = anchor.nickname
            
            // 3.所在城市
            cityBtn.setTitle(anchor.anchor_city, for: .normal)
            
            // 4.设置封面
            guard let iconURL = URL(string : anchor.vertical_src) else {
                return
            }
            iconImageView.kf_setImage(with: iconURL)
       
            
        }
    }
    

}
