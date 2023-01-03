//
//  UserManager.swift
//  Architecture
//
//  Created by Thaina da Silva Ebert on 02/01/23.
//

import Foundation

protocol UserManagerProtocol {
    func register(email: String, password: String, completionSucess: @escaping(UserModel) -> Void, completionFailure: @escaping(Error?) -> Void)
    func login(email: String, password: String, completionSucess: @escaping(UserModel) -> Void, completionFailure: @escaping(Error?) -> Void)
}

class UserManager: UserManagerProtocol {
    
    private let business: UserBusinessProtocol
    
    init(business: UserBusinessProtocol) {
        self.business = business
    }
    
    func register(
        email: String,
        password: String,
        completionSucess: @escaping (UserModel) -> Void,
        completionFailure: @escaping (Error?) -> Void) {
            business.register(email: email, password: password) { result in
                switch result {
                case .success(let response):
                    completionSucess(response)
                case .failure(let error):
                    completionFailure(error)
                }
            }
        }
    
    func login(
        email: String,
        password: String,
        completionSucess: @escaping (UserModel) -> Void,
        completionFailure: @escaping (Error?) -> Void) {
            business.login(email: email, password: password) { result in
                switch result {
                case .success(let response):
                    completionSucess(response)
                case .failure(let error):
                    completionFailure(error)
                }
            }
        }
}
