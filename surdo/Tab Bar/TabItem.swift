//
//  TabItem.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/10/23.
//

import UIKit

enum TabItem: Int {
    case main
    case translator
    case profile

    var image: UIImage? {
        switch self {
        case .main: return AppImage.mainTab.systemImage
        case .translator: return AppImage.translatorTab.systemImage
        case .profile: return AppImage.profileTab.systemImage
        }
    }

    var selectedImage: UIImage? {
        switch self {
        case .main: return AppImage.mainTabSelected.systemImage
        case .translator: return AppImage.translatorTabSelected.systemImage
        case .profile: return AppImage.profileTabSelected.systemImage
        }
    }
}
