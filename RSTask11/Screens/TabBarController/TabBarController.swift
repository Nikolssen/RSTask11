//
//  TabBarController.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/8/21.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        tabBar.tintColor = UIColor.coral
        tabBar.unselectedItemTintColor = UIColor.champagne
        tabBar.barTintColor = UIColor.queenBlue
        
        let vc1 = UIViewController()
        vc1.view.backgroundColor = UIColor.superWhite
        vc1.tabBarItem.selectedImage = UIImage.lego
        vc1.tabBarItem.image = UIImage.lego
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.coral
        vc2.tabBarItem.image = UIImage.rocket
        vc2.tabBarItem.selectedImage = UIImage.rocket
        
        setViewControllers([vc1, vc2], animated: true)
    }
}

extension TabBarController {
    enum Constants {
        static let animationDuration: TimeInterval = 0.25
    }
}

