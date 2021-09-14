//
//  UITabBarTransitions.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/9/21.
//

import Foundation
import UIKit


extension UITabBarController: UITabBarControllerDelegate {
    
    enum Constants {
        static let animationDuration: TimeInterval = 0.25
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let viewControllers = viewControllers, let fromVCIndex = viewControllers.firstIndex(of: fromVC), let toVCIndex = viewControllers.firstIndex(of: toVC)  else { return nil }
        if fromVCIndex < toVCIndex {
            return TabBarAnimatedTransitioning(style: .forward)
        }
        else {
            return TabBarAnimatedTransitioning(style: .backward)
        }
    }
}

class TabBarAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning{
    
    enum Style {
        case forward
        case backward
    }
    
    let style: TabBarAnimatedTransitioning.Style
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        UITabBarController.Constants.animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view
        else {
            transitionContext.completeTransition(false)
            return
        }
        let frame = transitionContext.initialFrame(for: fromVC)
        var fromFrameEnd = frame
        var toFrameStart = frame
        fromFrameEnd.origin.x = style == .forward ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = style == .forward ? frame.origin.x + frame.width : frame.origin.x - frame.width
        toView.frame = toFrameStart
        
        DispatchQueue.main.async {
            transitionContext.containerView.addSubview(toView)
            UIView.animate(withDuration: UITabBarController.Constants.animationDuration, animations: {
                fromView.frame = fromFrameEnd
                toView.frame = frame
            }, completion: {success in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(success)
            })
        }
    }
    
    init(style: TabBarAnimatedTransitioning.Style) {
        self.style = style
        super.init()
    }
}
