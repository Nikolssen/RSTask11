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
        if fromVC is LaunchpadDetailsViewController  && toVC is  LaunchpadListViewController{
            return LaunchpadBackwardTransitioning()
        }
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

class LaunchpadNavigationTransitioning: NSObject, UIViewControllerAnimatedTransitioning  {
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
        label.frame = contentView.convert(titleLabel.frame, from: currentCell)
        
        let locationLabel2 = UILabel()
        locationLabel2.text = locationLabel.text
        locationLabel2.font = locationLabel.font
        
        
        let shadowedView2 = ShadowedView()
        shadowedView2.style = shadowedView.style
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(contentView)
        contentView.addSubview(label)
        contentView.addSubview(locationLabel2)
        contentView.addSubview(shadowedView2)
        
        contentView.frame = containerView.convert(currentCell.frame, from: fromViewController.view)
        let shadowedViewSize = shadowedView.frame.size
        shadowedView2.frame = CGRect(origin: contentView.convert(shadowedView.frame, from: currentCell).origin, size: shadowedViewSize)
        
        locationLabel2.frame = contentView.convert(locationLabel.frame, from: currentCell)
        toViewController.stackView.alpha = 0.0
        toViewController.view.isHidden = true
        toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            contentView.frame = toViewController.view.frame
            contentView.layer.cornerRadius = 0
            contentView.frame = toViewController.view.frame
            let frame = CGRect(origin: contentView.convert(toViewController.statusView.frame, from: toViewController.view).origin, size: shadowedViewSize)
            shadowedView2.frame = frame
        }
        animator.addCompletion{position in
            toViewController.view.isHidden = false
            contentView.removeFromSuperview()
            transitionContext.completeTransition(position == .end)
            UIView.animate(withDuration: 0.15, delay: 0, options: [.transitionCurlDown], animations: {toViewController.stackView.alpha = 1.0}, completion: nil)
        }
        
        animator.startAnimation()
    }
    
    private let duration: TimeInterval = 0.24
}

class LaunchpadBackwardTransitioning: NSObject, UIViewControllerAnimatedTransitioning  {
    private let duration: TimeInterval = 0.24

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? LaunchpadDetailsViewController,
              let toViewController = transitionContext.viewController(forKey: .to) as? LaunchpadListViewController,
              let currentCell = toViewController.selectedCell as? LaunchpadCell,
              let titleLabel = fromViewController.titleLabel,
              let locationLabel = fromViewController.fullNameLabel,
              let shadowedView = fromViewController.statusView
              else { return }

        let containerView = transitionContext.containerView

        containerView.frame = toViewController.view.frame
        
        let contentView = UIView()
        contentView.backgroundColor = .superWhite
        contentView.frame = toViewController.view.frame
        

        let label = UILabel()
        label.font = titleLabel.font
        label.text = titleLabel.text
        label.frame = contentView.convert(titleLabel.frame, from: fromViewController.view)

        let locationLabel2 = UILabel()
        locationLabel2.text = locationLabel.text
        locationLabel2.font = locationLabel.font


        let shadowedView2 = ShadowedView()
        shadowedView2.style = shadowedView.style

        containerView.addSubview(toViewController.view)
        containerView.addSubview(contentView)
        contentView.addSubview(label)
        contentView.addSubview(locationLabel2)
        contentView.addSubview(shadowedView2)

        contentView.frame = containerView.convert(currentCell.frame, from: toViewController.view)
        let shadowedViewSize = shadowedView.frame.size
        shadowedView2.frame = CGRect(origin: contentView.convert(shadowedView.frame, from: fromViewController.view).origin, size: shadowedViewSize)
        
        locationLabel2.frame = contentView.convert(locationLabel.frame, from: toViewController.view)

        toViewController.view.isHidden = false
        
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {

            contentView.layer.cornerRadius = 0
            contentView.frame = containerView.convert(currentCell.frame, from: toViewController.view)
            label.frame = contentView.convert(currentCell.nameLabel.frame, from: currentCell)
            let frame = CGRect(origin: contentView.convert(currentCell.shadowedView.frame, from: currentCell).origin, size: shadowedViewSize)
            shadowedView2.frame = frame
            contentView.layer.cornerRadius = currentCell.layer.cornerRadius
        }
        animator.addCompletion{position in
            contentView.removeFromSuperview()
            transitionContext.completeTransition(position == .end)

        }
        UIView.animate(withDuration: 0.15, delay: 0, options: [.transitionCurlDown], animations: {fromViewController.stackView.alpha = 0}, completion: {_ in animator.startAnimation()})
    }

}
