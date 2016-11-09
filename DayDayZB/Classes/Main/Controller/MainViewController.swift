//
//  MainViewController.swift
//  DayDayZB
//
//  Created by 洛洛大人 on 16/11/3.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
        
    }
    
    
    private func addChildVC(storyName : String) {
        let childVC = UIStoryboard(name : storyName, bundle : nil).instantiateInitialViewController()
        
        addChildViewController(childVC!)
        
    }
    
    
}
