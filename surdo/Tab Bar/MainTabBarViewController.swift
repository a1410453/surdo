//
//  MainTabBarViewController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/10/23.
//

import UIKit

final class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        setValue(CustomTabBar(), forKey: "tabBar")
        view.backgroundColor = AppColor.tabbar.uiColor
        let main = UINavigationController(rootViewController: StagesViewController())
        let translator = UINavigationController(rootViewController: FirstLetterController())
        let profile = UINavigationController(rootViewController: FirstLetterController())
        main.tabBarItem = tabItem(for: .main)
        translator.tabBarItem = tabItem(for: .translator)
        profile.tabBarItem = tabItem(for: .profile)
        setViewControllers([main, translator, profile], animated: true)
        selectedIndex = 0
    }

    private func tabItem(for type: TabItem) -> UITabBarItem {
        let item = UITabBarItem(title: nil,
                     image: type.image,
                     selectedImage: type.selectedImage)
        item.imageInsets = UIEdgeInsets(top: 16, left: 0, bottom: -16, right: 0)
        return item
    }
}
