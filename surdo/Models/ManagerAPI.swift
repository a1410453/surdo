//
//  ManagerAPI.swift
//  surdo
//
//  Created by Rustem Orazbayev on 12/13/23.
//

import Foundation

struct ManagerAPI {
    // MARK: Video
    static let baseURL = 
    "https://firebasestorage.googleapis.com/v0/b/surdo-e3bd9.appspot.com/o/alphabet_videos%2F"
    static let tokenURL = ".mp4?alt=media"
    static var middle = 0
    static func makeURL() -> URL {
        let urlString = "\(baseURL)\(middle)\(tokenURL)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    static func makeURL(middlePart: Int) -> URL {
        let urlString = "\(baseURL)\(middlePart)\(tokenURL)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        return url
    }
 
    // MARK: Picture
    static let basePictureURL = 
    "https://firebasestorage.googleapis.com/v0/b/surdo-e3bd9.appspot.com/o/alphabet_pictures%2F"
    static let tokenPictureURL = ".png?alt=media"
    
    static func makePictureURL(middlePart: Int) -> URL {
        let urlString = "\(basePictureURL)\(middlePart)\(tokenPictureURL)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    // MARK: Word
    static let baseWordURL = "https://firebasestorage.googleapis.com/v0/b/surdo-e3bd9.appspot.com/o/words"
    static var wordTopic = "%2FA%2FA"
    static let tokenWordURL = ".mp4?alt=media"
    static func makeWordURL(middlePart: Int) -> URL {
        let urlString = "\(baseWordURL)\(wordTopic)\(middlePart)\(tokenWordURL)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        print(url)
        return url
    }
}
