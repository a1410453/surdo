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
        layer.backgroundColor = AppColor.tabbar.cgColor
        layer.borderColor = AppColor.tabbar.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
