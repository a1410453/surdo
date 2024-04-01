//
//  TabItem.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/10/23.
//

import UIKit

enum TabItem: Int {
    case main
    case recognizer
    case pedestal
    case profile

    var image: UIImage? {
        switch self {
        case .main: return AppImage.mainTab.systemImage
        case .recognizer: return AppImage.recognizerTab.systemImage
        case .pedestal: return AppImage.pedestalTab.systemImage
        case .profile: return AppImage.profileTab.systemImage
        }
    }

    var selectedImage: UIImage? {
        switch self {
        case .main: return AppImage.mainTabSelected.systemImage
        case .recognizer: return AppImage.recognizerTabSelected.systemImage
        case .pedestal: return AppImage.pedestalTabSelected.systemImage
        case .profile: return AppImage.profileTabSelected.systemImage
        }
    }
}
