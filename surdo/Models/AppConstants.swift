//
//  AppConstants.swift
//  surdo
//
//  Created by Rustem Orazbayev on 12/13/23.
//

import Foundation
// swiftlint: disable all
struct AppConstants {
    static let baseURL = "https://firebasestorage.googleapis.com/v0/b/surdo-e3bd9.appspot.com/o/alphabet_videos%2F"
    static let tokenURL = ".mp4?alt=media"
    
    static func makeURL(middlePart: String) -> URL {
        let urlString = "\(baseURL)\(middlePart)\(tokenURL)"
        return URL(string: urlString)!
    }
}
// swiftlint: enable all
