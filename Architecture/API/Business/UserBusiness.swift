//
//  UserBusiness.swift
//  Architecture
//
//  Created by Thaina da Silva Ebert on 02/01/23.
//

import Foundation

protocol UserBusinessProtocol {
    func register(email: String, password: String, completion: @escaping(Result<UserModel, Error>) -> Void)
    func login(email: String, password: String, completion: @escaping(Result<UserModel, Error>) -> Void)
}

class UserBusiness: UserBusinessProtocol {
    private let provider: UserProvider = UserProvider()
    
    func register(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        provider.register(parameters: getParameters(email: email, password: password)) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        provider.login(parameters: getParameters(email: email, password: password)) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getParameters(email: String, password: String) -> [AnyHashable :  Any] {
        let userModel = UserModel(email: email, password: password)
        let parameters: [AnyHashable : Any] = ["body" : ["userModel" : userModel]]
        
        return parameters
    }
    
}
