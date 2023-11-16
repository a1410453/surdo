//
//  User.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/15/23.
//

import Foundation
import Firebase

struct SurdoUser: Codable {
    let id: String
    var fullName: String = ""
    var username: String = ""
    var createdOn: Date = Date()
    var avatarPath: String = ""
    var isUserOnboarded: Bool = false
    var learningProgress: String = ""
    var achievements: String = ""
    var learningScore: String = ""
    var socialMedia: String = ""

    init(from user: User) {
        self.id = user.uid
    }
    
}
