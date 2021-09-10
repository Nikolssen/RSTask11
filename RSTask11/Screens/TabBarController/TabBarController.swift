//
//  TabBarController.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/8/21.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension TabBarController {
    enum Constants {
        static let animationDuration: TimeInterval = 0.25
    }
}

