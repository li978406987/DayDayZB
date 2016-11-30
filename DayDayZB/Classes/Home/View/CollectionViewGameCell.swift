//
//  CollectionViewGameCell.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/14.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

class CollectionViewGameCell: UICollectionViewCell {
    
    // Mark: - 控件属性
    @IBOutlet var iconImageView: UIImageView!

    @IBOutlet var titleLabel: UILabel!
    // MArk: - 定义模型属性
    var baseGame : BaseGameModel? {
        didSet {
            titleLabel.text = baseGame?.tag_name
            
            if let iconURL = URL(string: baseGame?.icon_url ?? "") {
            iconImageView.kf.setImage(with: iconURL)
            } else {
               iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    // Mark: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

}
