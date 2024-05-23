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
    case recognizerTab = "hand.app"
    case pedestalTab = "person.3.sequence"
    case profileTab = "person.crop.circle"
    case mainTabSelected = "house.fill"
    case recognizerTabSelected = "hand.app.fill"
    case pedestalTabSelected = "person.3.sequence.fill"
    case profileTabSelected = "person.crop.circle.fill"
    case next = "arrow.forward.circle.fill"
    case signOut = "rectangle.portrait.and.arrow.right.fill"
    case achieviment = "achievement"
    case pedestal = "pedestal"
    case errorIcon = "database"
    case support = "square.and.pencil.circle.fill"
    case privacy = "doc.text.fill"
    
    case achievement0 = "achievement0"
    case achievement1 = "achievement1"
    case achievement2 = "achievement2"
    case achievement3 = "achievement3"
    case achievement4 = "achievement4"
    case achievement5 = "achievement5"
    case achievement6 = "achievement6"
    case achievement7 = "achievement7"
    case achievement8 = "achievement8"
    case achievement9 = "achievement9"
    
    case confetti = "confetti"
}
