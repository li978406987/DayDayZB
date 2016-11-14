//
//  CollectionViewCycleCell.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/12.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

class CollectionViewCycleCell: UICollectionViewCell {
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    // Mark: - 控件属性

    // Mark : - 定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: iconURL)
        }
    }

}
