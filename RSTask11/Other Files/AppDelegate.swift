//
//  AppDelegate.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/8/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        confugureAppearence()
        self.window = window
        self.coordinator = Coordinator(window: window)
        coordinator.start()
        window.makeKeyAndVisible()
        return true
    }
}

extension AppDelegate {
    func confugureAppearence() {
        let tabBarItemAppearence = UITabBarItem.appearance()
        tabBarItemAppearence.setTitleTextAttributes([.font: UIFont.robotoMedium10, .foregroundColor: UIColor.champagne], for: .normal)
        tabBarItemAppearence.setTitleTextAttributes([.font: UIFont.robotoMedium10, .foregroundColor: UIColor.coral], for: .selected)
        
        let tabBarAppearence = UITabBar.appearance()
        tabBarAppearence.tintColor = .coral
        tabBarAppearence.unselectedItemTintColor = .champagne
        tabBarAppearence.barTintColor = .queenBlue
        tabBarAppearence.backgroundImage = UIImage()
        tabBarAppearence.isTranslucent = false
        let navigationBarAppearence = UINavigationBar.appearance()
        navigationBarAppearence.barTintColor = .queenBlue
        navigationBarAppearence.isTranslucent = false
        navigationBarAppearence.setBackgroundImage(UIImage(), for: .default)
        navigationBarAppearence.titleTextAttributes = [.font: UIFont.robotoBold24, .foregroundColor : UIColor.superWhite]
        let barButtonItemAppearence = UIBarButtonItem.appearance()
        barButtonItemAppearence.setTitleTextAttributes([.font: UIFont.robotoMedium17, .foregroundColor: UIColor.champagne], for: .highlighted)
        barButtonItemAppearence.setTitleTextAttributes([.font: UIFont.robotoMedium17, .foregroundColor: UIColor.coral], for: .normal)
        barButtonItemAppearence.tintColor = .coral
    }
}
