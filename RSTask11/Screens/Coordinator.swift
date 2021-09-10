//
//  Coordinator.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/10/21.
//

import Foundation
import UIKit

class Coordinator {
    
    let window: UIWindow
    
    func start() {
        self.window.rootViewController = tabBarController
    }
    
    init(window: UIWindow){
        self.window = window
    }
    
    var tabBarController: TabBarController {
        let tabBarController = TabBarController()
        tabBarController.setViewControllers([rocketListNavigationController, launchListNavigationController, launchpadListNavigationController], animated: false)
        return tabBarController
    }
    
    var rocketListNavigationController: UINavigationController {
        
        let rocketListViewController = RocketListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: rocketListViewController)
        navigationController.tabBarItem.image = .rocket
        navigationController.tabBarItem.selectedImage = .rocket
        navigationController.tabBarItem.title = Strings.TabBar.rocket
        return navigationController
    }
    
    var launchListNavigationController: UINavigationController {
        let launchListViewController = LaunchListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: launchListViewController)
        navigationController.tabBarItem.image = .adjustment
        navigationController.tabBarItem.selectedImage = .adjustment
        navigationController.tabBarItem.title = Strings.TabBar.launch
        return navigationController
    }
    
    var launchpadListNavigationController: UINavigationController {
        let launchpadListViewController = LaunchpadListViewController(collectionViewLayout: UICollectionViewLayout())
        let navigationController = UINavigationController(rootViewController: launchpadListViewController)
        navigationController.tabBarItem.image = .lego
        navigationController.tabBarItem.selectedImage = .lego
        navigationController.tabBarItem.title = Strings.TabBar.launchpad
        return navigationController
    }
}
