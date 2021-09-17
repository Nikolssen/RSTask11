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
//        if fromVC is RocketListViewController && toVC is RocketDetailsViewController {
//            return RocketNavigationTransitioning()
//        }
        return nil
    }
}

//class RocketNavigationTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
//    private let duration: TimeInterval = 0.24
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return duration
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let fromViewController = transitionContext.viewController(forKey: .from) as? RocketListViewController,
//              let toViewController = transitionContext.viewController(forKey: .to) as? RocketDetailsViewController,
//              let currentCell = fromViewController.selectedCell as? RocketCell else { return }
//
//
//        let containerView = transitionContext.containerView
//
//        let contentView = UIView()
//        contentView.backgroundColor = .superWhite
//        contentView.frame = containerView.convert(currentCell.frame, from: fromViewController.view)
//        contentView.layer.cornerRadius = currentCell.layer.cornerRadius
//
//        let snapshotImageView = UIImageView(image: currentCell.imageView.image)
//        snapshotImageView.contentMode = currentCell.imageView.contentMode
//        snapshotImageView.frame = currentCell.imageView.frame
//
//        let titleLabel = UILabel()
//
//        titleLabel.text = currentCell.titleLabel.text
//        titleLabel.textColor = currentCell.titleLabel.textColor
//        titleLabel.font = currentCell.titleLabel.font
//
//        titleLabel.frame = currentCell.titleLabel.frame
//
//
//        toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
//
//        containerView.addSubview(toViewController.view)
//        containerView.addSubview(contentView)
//        contentView.addSubview(snapshotImageView)
//        contentView.addSubview(titleLabel)
//
//        toViewController.view.isHidden = true
//        containerView.backgroundColor = nil
//
//        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
//
//            contentView.frame = containerView.convert(toViewController.view.frame, from: toViewController.view)
//            snapshotImageView.frame = contentView.convert(toViewController.imageView.frame, from: toViewController.view)
//            titleLabel.frame = toViewController.titleLabel.frame
//            titleLabel.textColor = .superWhite
//            titleLabel.font = toViewController.titleLabel.font
//        }
//        animator.addCompletion{position in
//            toViewController.view.isHidden = false
//            titleLabel.removeFromSuperview()
//            snapshotImageView.removeFromSuperview()
//            contentView.removeFromSuperview()
//            transitionContext.completeTransition(position == .end)
//            UIView.animate(withDuration: 0.15, delay: 0, options: [.transitionCurlDown], animations: {toViewController.stackView.alpha = 1.0}, completion: nil)
//        }
//
//        animator.startAnimation()
//
//    }
//
//
//}

class LaunchpadNavigationTransitioning: NSObject, UIViewControllerAnimatedTransitioning  {
    private let duration: TimeInterval = 0.24
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? LaunchpadListViewController,
              let toViewController = transitionContext.viewController(forKey: .to) as? LaunchpadDetailsViewController,
              let currentCell = fromViewController.selectedCell as? LaunchpadCell,
              let titleLabel = currentCell.nameLabel,
              let locationLabel = currentCell.locationLabel,
              let shadowedView = currentCell.shadowedView
              else { return }
        
        let containerView = transitionContext.containerView
        
        containerView.backgroundColor = .superWhite
        
        let contentView = UIView()
        contentView.backgroundColor = .superWhite
        contentView.frame = contentView.bounds
        contentView.layer.cornerRadius = currentCell.layer.cornerRadius
        
        let label = UILabel()
        label.font = titleLabel.font
        label.text = titleLabel.text
        label.frame = titleLabel.frame
        
        let locationLabel2 = UILabel()
        locationLabel2.text = locationLabel.text
        locationLabel2.font = locationLabel.font
        
        
        let shadowedView2 = ShadowedView(frame: shadowedView.frame)
        
        shadowedView2.style = shadowedView.style
        shadowedView.layoutIfNeeded()
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(contentView)
        contentView.addSubview(label)
        contentView.addSubview(locationLabel2)
        contentView.addSubview(shadowedView2)
        
        contentView.frame = containerView.convert(currentCell.frame, from: fromViewController.collectionView)

        shadowedView2.frame = shadowedView.frame
        locationLabel2.frame = locationLabel.frame
        
        toViewController.stackView.alpha = 0.0
        toViewController.view.isHidden = true
        toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            contentView.frame = toViewController.view.frame
            contentView.layer.cornerRadius = 0
            contentView.frame = toViewController.view.frame
        }
        animator.addCompletion{position in
            toViewController.view.isHidden = false
            contentView.removeFromSuperview()
            transitionContext.completeTransition(true)
            UIView.animate(withDuration: 0.15, delay: 0, options: [.transitionCurlDown], animations: {toViewController.stackView.alpha = 1.0}, completion: nil)
        }
        
        animator.startAnimation()
    }

}
