//
//  MainTabBarController.swift
//  Shitflix
//
//  Created by BCamp User on 01/08/2019.
//  Copyright © 2019 BCamp User. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let homepageVC = HomepageViewController()
    let findVC = FindViewController()
    let downloadVC = DownloadViewController()
    let otherVC = OtherViewController()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
        style()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        homepageVC.tabBarItem.image = UIImage(named: "homepage-icon-normal")
        homepageVC.tabBarItem.selectedImage = UIImage(named: "homepage-icon-selected")
        
        findVC.tabBarItem.image = UIImage(named: "find-icon-normal")
        findVC.tabBarItem.selectedImage = UIImage(named: "find-icon-selected")
        
        downloadVC.tabBarItem.image = UIImage(named: "download-icon-normal")
        downloadVC.tabBarItem.selectedImage = UIImage(named: "download-icon-selected")
        
        otherVC.tabBarItem.image = UIImage(named: "other-icon-normal")
        otherVC.tabBarItem.selectedImage = UIImage(named: "other-icon-selected")
        
        self.viewControllers = [homepageVC, findVC, downloadVC, otherVC]
        self.selectedIndex = 0
    }
    
    private func style() {
        self.tabBar.barTintColor = .black
    }
    
}
