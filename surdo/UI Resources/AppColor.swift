//
//  AppColor.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/9/23.
//

import UIKit

protocol AppColorProtocol {
    var rawValue: String { get }
}

extension AppColorProtocol {

    var uiColor: UIColor {
        UIColor.init(named: rawValue) ?? .white
    }

    var cgColor: CGColor {
        return uiColor.cgColor
    }
}

enum AppColor: String, AppColorProtocol {
    case red = "red"
    case beige = "beige"
}

