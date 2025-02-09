//
//  TabBarController.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 2/3/25.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "Home"), tag: 0)
        
        
        let exploreVC = ExploreViewController(nibName: "ExploreViewController", bundle: nil)
        let exploreNav = UINavigationController(rootViewController: exploreVC)
        exploreNav.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "Explore"), tag: 1)
        
        
        let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(contentsOfFile: "person"), tag: 2)
        
        
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        
        self.viewControllers = [homeNav, exploreNav, profileNav]
        
        
        tabBar.tintColor = .systemBlue  // Active tab color
        tabBar.unselectedItemTintColor = .white// Inactive tab color using hexcode
        tabBar.backgroundColor = .systemOrange
    }
}


