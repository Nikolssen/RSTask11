//
//  LaunchpadNavigationTransitioning.swift
//  RSTask11
//
//  Created by Admin on 19.09.2021.
//

import Foundation
import UIKit

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
        contentView.frame = containerView.bounds
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
