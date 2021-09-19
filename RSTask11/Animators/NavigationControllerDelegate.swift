//
//  UINavigationControllerTransitions.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/15/21.
//

import Foundation
import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is LaunchpadListViewController && toVC is LaunchpadDetailsViewController {
            return LaunchpadNavigationTransitioning()
        }
        if fromVC is LaunchListViewController && toVC is LaunchDetailsViewController {
            return LaunchNavigationTransitioning()
        }
//        if fromVC is RocketListViewController && toVC is RocketDetailsViewController {
//            return RocketNavigationTransitioning()
//        }
        return nil
    }
}
