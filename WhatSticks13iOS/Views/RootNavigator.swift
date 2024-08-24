//
//  RootNavigator.swift
//  LaunchVideo02
//
//  Created by Nick Rodriguez on 23/08/2024.
//

import UIKit

class RootNavigator: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("-in RootNavigator viewDidLoad ")
        setupRootViewController()
        
    }
    
    private func setupRootViewController() {
        let hasShownLaunchVideo = UserDefaults.standard.bool(forKey: "hasShownLaunchVideo")
        print("setupRootViewController, hasShownLaunchVideo: \(hasShownLaunchVideo)")

        if hasShownLaunchVideo {
//            showHomeVC()
            showMainTabBar()
        } else {
            print("- about to present LaunchVideoVC()")
            let launchVideoVC = LaunchVideoVC()
            setViewControllers([launchVideoVC], animated: true)
        }
    }

    private func showHomeVC() {
        print("in showHomeVC")
        let homeVC = HomeVC()
        setViewControllers([homeVC], animated: false)
        UserDefaults.standard.set(true, forKey: "hasShownLaunchVideo")
    }
    
    func showMainTabBar(){
        print("- in showMainTabBar()")
        let mainTabBar = MainTabBarController()
        setViewControllers([mainTabBar], animated: true)
        UserDefaults.standard.set(true, forKey: "hasShownLaunchVideo")
    }
}

