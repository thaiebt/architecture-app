//
//  UserProvider.swift
//  Architecture
//
//  Created by Thaina da Silva Ebert on 02/01/23.
//

import Foundation
import FirebaseAuth

protocol UserProviderProtocol {
    func register(parameters: [AnyHashable: Any], completion: @escaping(Result<UserModel, Error>) -> Void)
    func login(parameters: [AnyHashable: Any], completion: @escaping(Result<UserModel, Error>) -> Void)
}

class UserProvider: UserProviderProtocol {
    
    lazy var auth = Auth.auth()
    
    func register(parameters: [AnyHashable : Any], completion: @escaping (Result<UserModel, Error>) -> Void) {
        let body: NSDictionary = parameters["body"] as? NSDictionary ?? [:]
        let model = body["userModel"] as? UserModel
        
        guard let model = model else { return }
        self.auth.createUser(withEmail: model.email, password: model.password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(model))
            }
        }
    }
    
    func login(parameters: [AnyHashable: Any], completion: @escaping(Result<UserModel, Error>) -> Void) {
        let body: NSDictionary = parameters["body"] as? NSDictionary ?? [:]
        let model = body["userModel"] as? UserModel
        
        guard let model = model else { return }
        self.auth.signIn(withEmail: model.email, password: model.password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(model))
            }
        }
    }
    
}
