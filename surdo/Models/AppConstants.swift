//
//  AppConstants.swift
//  surdo
//
//  Created by Rustem Orazbayev on 12/13/23.
//

import Foundation

// swiftlint: disable all
struct AppConstants {
    // MARK: Video
    static let baseURL = "https://firebasestorage.googleapis.com/v0/b/surdo-e3bd9.appspot.com/o/alphabet_videos%2F"
    static let tokenURL = ".mp4?alt=media"
    static func makeURL(middlePart: Int) -> URL {
        let urlString = "\(baseURL)\(middlePart)\(tokenURL)"
        return URL(string: urlString)!
    }
    
 
    // MARK: Picture
    static let basePictureURL = "https://firebasestorage.googleapis.com/v0/b/surdo-e3bd9.appspot.com/o/alphabet_pictures%2F"
    static let tokenPictureURL = ".png?alt=media"
    
    static func makePictureURL(middlePart: Int) -> URL {
        let urlString = "\(basePictureURL)\(middlePart)\(tokenPictureURL)"
        return URL(string: urlString)!
    }
}
// swiftlint: enable all
