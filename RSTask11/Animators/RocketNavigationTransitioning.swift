//
//  RocketNavigationTransitioning.swift
//  RSTask11
//
//  Created by Admin on 19.09.2021.
//

import Foundation
import UIKit


class RocketNavigationTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration: TimeInterval = 0.24

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? RocketListViewController,
              let toViewController = transitionContext.viewController(forKey: .to) as? RocketDetailsViewController,
              let currentCell = fromViewController.selectedCell as? RocketCell else { return }


        let containerView = transitionContext.containerView

        let contentView = UIView()
        contentView.backgroundColor = .superWhite
        contentView.frame = containerView.convert(currentCell.frame, from: fromViewController.view)
        contentView.layer.cornerRadius = currentCell.layer.cornerRadius

        let snapshotImageView = UIImageView(image: currentCell.imageView.image)
        snapshotImageView.contentMode = currentCell.imageView.contentMode
        snapshotImageView.frame = currentCell.imageView.frame

        let titleLabel = UILabel()

        titleLabel.text = currentCell.titleLabel.text
        titleLabel.textColor = currentCell.titleLabel.textColor
        titleLabel.font = currentCell.titleLabel.font

        toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
        
        let frame = currentCell.titleLabel.frame
        titleLabel.frame = frame
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(contentView)
        contentView.addSubview(snapshotImageView)
        contentView.addSubview(titleLabel)
        
        toViewController.stackView.alpha = 0.0
        toViewController.view.isHidden = true
        containerView.backgroundColor = nil

        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {

            contentView.frame = containerView.convert(toViewController.view.frame, from: toViewController.view)
            snapshotImageView.frame = contentView.convert(toViewController.imageView.frame, from: toViewController.view)
            titleLabel.frame = CGRect(origin: toViewController.titleLabel.frame.origin, size: CGSize(width: toViewController.view.frame.width, height: toViewController.titleLabel.frame.height))
            titleLabel.textColor = .black
            titleLabel.font = toViewController.titleLabel.font
        }
        animator.addCompletion{_ in
            toViewController.view.isHidden = false
            contentView.removeFromSuperview()
            transitionContext.completeTransition(true)
            UIView.animate(withDuration: 0.15, delay: 0, options: [.transitionCurlDown], animations: {toViewController.stackView.alpha = 1.0}, completion: nil)

        }

        animator.startAnimation()

    }


}

