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
        let tabBarController = TabBarController()
    }
    
    init(window: UIWindow){
        self.window = window
    }
    
    var tabBarController: TabBarController {
        let tabBarController = TabBarController()
        tabBarController.setViewControllers([rocketListViewController, launchListViewController, ], animated: false)
        return tabBarController
    }
    
    var rocketListViewController: RocketListViewController {
        let rocketListViewController = RocketListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        return rocketListViewController
    }
    
    var launchListViewController: LaunchListViewController {
        let launchListViewController = LaunchListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        return launchListViewController
    }
    
    var launchpadListViewController: LaunchpadListViewController {
        let launchpadListViewController = LaunchpadListViewController(collectionViewLayout: UICollectionViewLayout())
        return launchpadListViewController
    }
}
