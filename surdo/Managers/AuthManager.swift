//
//  AuthManager.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/15/23.
//

import Foundation
import Firebase
import FirebaseAuthCombineSwift
import Combine

final class AuthManager {
    static let shared = AuthManager()
    
    func registerUser(with email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().createUser(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
    
    func loginUser(with email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().signIn(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
        
    }
}
