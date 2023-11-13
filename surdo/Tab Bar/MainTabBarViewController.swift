//
//  MainTabBarViewController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/10/23.
//

import UIKit
import SnapKit

final class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        //setValue(CustomTabBar(), forKey: "tabBar")
        
        let customTabBarHeight: CGFloat = 400.0
        tabBar.frame.size.height = customTabBarHeight
        
        let customTabBar = CustomTabBar(frame: CGRect(x: 0, y: -30, width: tabBar.frame.width, height: tabBar.frame.height))
        tabBar.addSubview(customTabBar)
        tabBar.barTintColor = AppColor.tabbar.uiColor
        tabBar.tintColor = AppColor.red.uiColor
        view.backgroundColor = AppColor.tabbar.uiColor
        let main = UINavigationController(rootViewController: StagesViewController())
        let translator = UINavigationController(rootViewController: FirstLetterController())
        let profile = UINavigationController(rootViewController: FirstLetterController())
        main.tabBarItem = tabItem(for: .main)
        translator.tabBarItem = tabItem(for: .translator)
        profile.tabBarItem = tabItem(for: .profile)
        
        
        // main.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        setViewControllers([main, translator, profile], animated: true)
        selectedIndex = 0
        
    }

    private func tabItem(for type: TabItem) -> UITabBarItem {
        let item = UITabBarItem(title: nil,
                     image: type.image,
                     selectedImage: type.selectedImage)
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return item
    }
}
