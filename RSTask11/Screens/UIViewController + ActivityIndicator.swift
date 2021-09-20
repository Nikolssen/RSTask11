//
//  UIViewController + ActivityIndicator.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/20/21.
//

import UIKit

extension UIViewController {
    
    func showActivity() {
        
       
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.titleView?.isHidden = true
        
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.restorationIdentifier = "Activity Indicator"
        activityIndicator.startAnimating()
        
        
    }
    func hideActivity() {
        for item in view.subviews where item.restorationIdentifier == "Activity Indicator" {
            (item as? UIActivityIndicatorView)?.stopAnimating()
            item.removeFromSuperview()
        }
        
        navigationItem.rightBarButtonItem?.isEnabled = true
        navigationItem.titleView?.isHidden = false
    }
    
    func showErrorAlert(retryCallback: (() -> Void)?) {
        let alertController = UIAlertController(title: "Error", message: "A network or decoding error happened. Check network connection and retry later.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {_ in alertController.dismiss(animated: true, completion: nil)}))
        if let retryCallback = retryCallback {
            alertController.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: {_ in
                retryCallback()
                alertController.dismiss(animated: true, completion: nil)
            }))
        }
        present(alertController, animated: true, completion: nil)
    }
}
