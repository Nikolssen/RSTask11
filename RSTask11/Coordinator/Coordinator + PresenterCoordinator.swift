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
              let navigationController = tabBarController.selectedViewController as? UINavigationController else { return }
        let launchDetailsViewController =
            LaunchDetailsViewController(nibName: "LaunchDetailsViewController", bundle: nil)
        let launchDetailsPresenter = LaunchDetailsPresenter(service: service, model: model, coordinator: self)
        launchDetailsViewController.presenter = launchDetailsPresenter
        launchDetailsPresenter.delegate = launchDetailsViewController
        navigationController.pushViewController(launchDetailsViewController, animated: true)
    }
}

extension Coordinator: LaunchpadListPresenterCoordinator {
    func showDetails(model: Launchpad) {
        guard let tabBarController = window.rootViewController as? UITabBarController,
              let navigationController = tabBarController.selectedViewController as? UINavigationController else { return }
        let launchpadDetailsViewController =
            LaunchpadDetailsViewController(nibName: "LaunchpadDetailsViewController", bundle: nil)
        let launchpadDetailsPresenter = LaunchpadDetailsPresenter(service: service, coordinator: self, model: model)
        launchpadDetailsViewController.presenter = launchpadDetailsPresenter
        navigationController.pushViewController(launchpadDetailsViewController, animated: true)
    }
}

extension Coordinator: DetailsCoordinator {
    func showFullscreenImage(with url: String) {
        guard let tabBarController = window.rootViewController as? UITabBarController,
              let navigationController = tabBarController.selectedViewController as? UINavigationController else { return }
        let imagePresenter = ImageViewPresenter(service: service, url: url)
        let imageViewController = ImageViewController()
        imageViewController.presenter = imagePresenter
        imageViewController.modalPresentationStyle = .fullScreen
        navigationController.topViewController?.present(imageViewController, animated: true, completion: nil)
    }
    
    func openWebViewLink(with url: String) {
        guard let tabBarController = window.rootViewController as? UITabBarController,
              let navigationController = tabBarController.selectedViewController as? UINavigationController else { return }
        guard let urlLink = URL(string: url) else { return }
        let webViewController = WebViewController(nibName: "WebViewController", bundle: nil)
        webViewController.url = urlLink
        navigationController.pushViewController(webViewController, animated: true)
    }

}
