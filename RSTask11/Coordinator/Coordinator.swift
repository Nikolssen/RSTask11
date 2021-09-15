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
    let service: ServiceType = Service()
    var delegates: [Any] = []
    func start() {
        self.window.rootViewController = tabBarController
    }

    init(window: UIWindow) {
        self.window = window
    }

    var tabBarController: UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.delegate = tabBarController

        tabBarController.setViewControllers(
            [rocketListNavigationController, launchListNavigationController, launchpadListNavigationController],
            animated: false)
        return tabBarController
    }

    var rocketListNavigationController: UINavigationController {

        let rocketListViewController = RocketListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let rocketListPresenter = RocketListPresenter(service: service, coordinator: self)
        rocketListPresenter.delegate = rocketListViewController
        rocketListViewController.presenter = rocketListPresenter
        let navigationController = UINavigationController(rootViewController: rocketListViewController)
        navigationController.tabBarItem.image = .rocket
        navigationController.tabBarItem.selectedImage = .rocket
        navigationController.tabBarItem.title = Strings.TabBar.rocket
        let delegate = RocketsNavigationControllerDelegate()
        navigationController.delegate = delegate
        delegates.append(delegate)
        return navigationController
    }

    var launchListNavigationController: UINavigationController {
        let launchListViewController = LaunchListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: launchListViewController)
        let launchListPresenter = LaunchListPresenter(service: service, coordinator: self)
        launchListPresenter.delegate = launchListViewController
        launchListViewController.presenter = launchListPresenter
        navigationController.tabBarItem.image = .adjustment
        navigationController.tabBarItem.selectedImage = .adjustment
        navigationController.tabBarItem.title = Strings.TabBar.launch
        return navigationController
    }

    var launchpadListNavigationController: UINavigationController {
        let launchpadListViewController =
            LaunchpadListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let launchpadListPresenter = LaunchpadListPresenter(service: service, coordinator: self)
        launchpadListPresenter.delegate = launchpadListViewController
        launchpadListViewController.presenter = launchpadListPresenter
        let navigationController = UINavigationController(rootViewController: launchpadListViewController)
        navigationController.tabBarItem.image = .lego
        navigationController.tabBarItem.selectedImage = .lego
        navigationController.tabBarItem.title = Strings.TabBar.launchpad
        return navigationController
    }
}
