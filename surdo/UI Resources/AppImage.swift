//
//  AppImage.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/9/23.
//

import UIKit

protocol AppImageProtocol {
    var rawValue: String { get }
}

extension AppImageProtocol {

    var uiImage: UIImage? {
        guard let image = UIImage(named: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }

    var systemImage: UIImage? {
        guard let image = UIImage(systemName: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
}

enum AppImage: String, AppImageProtocol {
    case gesture = "gesture"
    case mainTab = "house"
    case translatorTab = "hand.raised.square.on.square"
    case profileTab = "person.crop.circle"
    case mainTabSelected = "house.fill"
    case translatorTabSelected = "hand.raised.square.on.square.fill"
    case profileTabSelected = "person.crop.circle.fill"
    case next = "arrow.forward.circle.fill"
    case signOut = "rectangle.portrait.and.arrow.right"
}
