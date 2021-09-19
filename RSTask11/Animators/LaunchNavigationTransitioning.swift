//
//  LaunchNavigationTransitioning.swift
//  RSTask11
//
//  Created by Admin on 19.09.2021.
//

import Foundation
import UIKit

class LaunchNavigationTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration: TimeInterval = 0.24
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? LaunchListViewController,
              let toViewController = transitionContext.viewController(forKey: .to) as? LaunchDetailsViewController,
              let currentCell = fromViewController.selectedCell as? LaunchCell else { return }
        let containerView = transitionContext.containerView
        
        containerView.backgroundColor = .superWhite
        
        let contentView = UIView()
        contentView.backgroundColor = .superWhite
        contentView.frame = containerView.convert(currentCell.frame, from: fromViewController.collectionView)
        contentView.layer.cornerRadius = currentCell.layer.cornerRadius
        
        let titleLabel = UILabel()
        titleLabel.frame = currentCell.titleLabel.frame
        titleLabel.text = currentCell.titleLabel.text
        titleLabel.textColor = currentCell.titleLabel.textColor
        titleLabel.font = currentCell.titleLabel.font
        
        let dateLabel = UILabel()
        dateLabel.frame = currentCell.dateLabel.frame
        dateLabel.text = currentCell.dateLabel.text
        dateLabel.textColor = currentCell.dateLabel.textColor
        dateLabel.font = currentCell.dateLabel.font
        
        let indicatorView = IndicatorView(frame: currentCell.indicatorView.frame, true)
        indicatorView.style = currentCell.indicatorView.style
        
        let shadowedView = ShadowedView(frame: currentCell.shadowedView.frame)
        shadowedView.style = currentCell.shadowedView.style
        
        let shadowedImageView = ShadowedImageView(frame: currentCell.shadowedImageView.frame, true)
        shadowedImageView.imageView.image = currentCell.shadowedImageView.imageView.image
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(indicatorView)
        contentView.addSubview(shadowedView)
        contentView.addSubview(shadowedImageView)
        
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
