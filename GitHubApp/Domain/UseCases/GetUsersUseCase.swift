//
//  GetUsersUseCase.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/26/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation

typealias GetUsersUseCaseCompletionHandler = (_ users: Result<[User], Error>) -> Void

protocol GetUsersUseCase {
    func getUsers(params: GetUsersParameters, completionHandler: @escaping GetUsersUseCaseCompletionHandler)
}

struct GetUsersParameters {
    let since: Int
}

class GetUsersUseCaseImpl: GetUsersUseCase {
    
    let gateway: UsersGateway
    
    init(gateway: UsersGateway) {
        self.gateway = gateway
    }
    
    func getUsers(params: GetUsersParameters, completionHandler: @escaping GetUsersUseCaseCompletionHandler) {
        self.gateway.getUsers(params: params) { (result) in
            completionHandler(result)
        }
    }
    
}
