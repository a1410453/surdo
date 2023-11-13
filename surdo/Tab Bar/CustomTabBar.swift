//
//  CustomTabBar.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/10/23.
//

import UIKit

final class CustomTabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) { nil }

    private func setup() {
        layer.borderColor = AppColor.tabbar.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
        layer.cornerRadius = 40
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        barTintColor = AppColor.tabbar.uiColor
        tintColor = AppColor.red.uiColor
    }
}
