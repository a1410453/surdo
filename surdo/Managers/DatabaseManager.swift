//
//  DatabaseManager.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/15/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift
import Combine

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    let db = Firestore.firestore()
    let usersPath: String = "users"
    
    func collectionUsers(add user: User) -> AnyPublisher<Bool, Error> {
        let surdoUser = SurdoUser(from: user)
        return db.collection(usersPath).document(surdoUser.id).setData(from: surdoUser)
            .map { _ in
                return true
            }
            .eraseToAnyPublisher()
    }
    
    func collectionUsers(retrieve id: String) -> AnyPublisher<SurdoUser, Error> {
        db.collection(usersPath).document(id).getDocument()
            .tryMap { try $0.data(as: SurdoUser.self) }
            .eraseToAnyPublisher()
    }
    
    func collectionUsers(updateFields: [String: Any], for id: String) -> AnyPublisher<Bool, Error> {
        db.collection(usersPath).document(id).updateData(updateFields)
            .map { _ in true }
            .eraseToAnyPublisher()
    }
    
    func collectionUsers(completion: @escaping ([(username: String,
                                                  learningScore: String)]) -> Void) {
        db.collection(usersPath)
            .order(by: "learningScore", descending: true)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting users: \(error)")
                    completion([])
                } else {
                    let users = querySnapshot?.documents.compactMap { document -> (username: String,
                                                                                   learningScore: String)? in
                        guard let username = document["username"] as? String,
                              let learningScore = document["learningScore"] as? String else {
                            return nil
                        }
                        return (username: username,
                                learningScore: learningScore)
                    } ?? []
                    
                    completion(users)
                }
            }
    }
    
}
