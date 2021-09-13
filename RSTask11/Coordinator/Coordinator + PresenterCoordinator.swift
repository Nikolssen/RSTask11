//
//  Coordinator + PresenterCoordinator.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/10/21.
//

import Foundation
import UIKit


extension Coordinator: RocketListPresenterCoordinator {
    func showDetails(model: Rocket) {
        guard let tabBarController = window.rootViewController as? UITabBarController,
              let navigationController = tabBarController.viewControllers?[0] as? UINavigationController else { return }
        let rocketDetailsViewController =
            RocketDetailsViewController(nibName: "RocketDetailsViewController", bundle: nil)
        let rocketDetailsPresenter = RocketDetailsPresenter(service: service, model: model, coordinator: self)
        rocketDetailsViewController.presenter = rocketDetailsPresenter
        navigationController.pushViewController(rocketDetailsViewController, animated: true)
    }
}

extension Coordinator: LaunchListPresenterCoordinator {
    func showDetails(model: Launch) {
        guard let tabBarController = window.rootViewController as? UITabBarController,
              let navigationController = tabBarController.viewControllers?[1] as? UINavigationController else { return }
        let launchDetailsViewController =
            LaunchDetailsViewController(nibName: "LaunchDetailsViewController", bundle: nil)
        navigationController.pushViewController(launchDetailsViewController, animated: true)
    }
}

extension Coordinator: LaunchpadListPresenterCoordinator {
    func showDetails(model: Launchpad) {
        guard let tabBarController = window.rootViewController as? UITabBarController,
              let navigationController = tabBarController.viewControllers?[2] as? UINavigationController else { return }
        let launchpadDetailsViewController =
            LaunchDetailsViewController(nibName: "LaunchpadDetailsViewController", bundle: nil)
        navigationController.pushViewController(launchpadDetailsViewController, animated: true)
    }
}

extension Coordinator: RocketDetailsCoordinator {
    func showFullscreenImage(with url: String) {
        
    }
    
    func openWebViewLink(with url: String) {
        guard let tabBarController = window.rootViewController as? UITabBarController,
              let navigationController = tabBarController.viewControllers?[0] as? UINavigationController else { return }
        guard let urlLink = URL(string: url) else { return }
        let webViewController = WebViewController(nibName: "WebViewController", bundle: nil)
        webViewController.url = urlLink
        navigationController.pushViewController(webViewController, animated: true)
    }

}
