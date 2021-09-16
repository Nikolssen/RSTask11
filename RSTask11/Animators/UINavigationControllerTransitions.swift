//
//  UINavigationControllerTransitions.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/15/21.
//

import Foundation
import UIKit

class RocketsNavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if fromVC is RocketListViewController && toVC is RocketDetailsViewController {
//            return RocketNavigationTransitioning()
//        }
        return nil
    }
}
//
//class RocketNavigationTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
//    private let duration: TimeInterval = 3
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return duration
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let fromViewController = transitionContext.viewController(forKey: .from) as? RocketListViewController,
//              let toViewController = transitionContext.viewController(forKey: .to) as? RocketDetailsViewController,
//              let currentCell = fromViewController.selectedCell() as? RocketCell else { return }
//
//        let containerView = transitionContext.containerView
//
//        let snapshotContentView = UIView()
//        snapshotContentView.backgroundColor = .superWhite
//        snapshotContentView.frame = containerView.convert(currentCell.frame, from: fromViewController.view)
//        snapshotContentView.layer.cornerRadius = currentCell.contentView.layer.cornerRadius
//
//        let snapshotImageView = UIImageView(image: currentCell.imageView.image)
//        snapshotImageView.contentMode = currentCell.imageView.contentMode
//        snapshotImageView.frame = containerView.convert(currentCell.imageView.frame, from: currentCell)
//
//        let titleLabel = UILabel()
//
//        titleLabel.text = currentCell.titleLabel.text
//        titleLabel.textColor = currentCell.titleLabel.textColor
//        titleLabel.font = currentCell.titleLabel.font
//
//
//        titleLabel.frame = containerView.convert(currentCell.titleLabel.frame, from: fromViewController.view)
//
//
//        toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
//        containerView.addSubview(toViewController.view)
//        containerView.addSubview(snapshotContentView)
//        containerView.addSubview(snapshotImageView)
//        containerView.addSubview(titleLabel)
//
//        toViewController.view.isHidden = true
//        containerView.backgroundColor = nil
//
//
//
//        UIView.transition(with: containerView, duration: duration, options: .curveEaseInOut, animations: {
//
//            snapshotContentView.frame = containerView.convert(toViewController.view.frame, from: toViewController.view)
//            snapshotImageView.frame = containerView.convert(toViewController.imageView.frame, from: toViewController.view)
//            titleLabel.frame = containerView.convert(toViewController.titleLabel.frame, from: toViewController.view)
//            titleLabel.textColor = .darkGray
//            titleLabel.font = toViewController.titleLabel.font
//        }, completion: { position in
//            toViewController.view.isHidden = false
//            titleLabel.removeFromSuperview()
//            snapshotImageView.removeFromSuperview()
//            snapshotContentView.removeFromSuperview()
//            transitionContext.completeTransition(position)
//        })
//    }
//
//
//}
