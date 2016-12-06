//
//  CollectionHeaderView.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/9.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    
    // Mark : - 控件属性
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var moreBtn: UIButton!
    // Mark : - 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named : group?.icon_name ?? "home_header_normal")
        }
    }
}
