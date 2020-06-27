//
//  GetUserUseCase.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation

typealias GetUserUseCaseCompletionHandler = (_ user: Result<User, Error>) -> Void

protocol GetUserUseCase {
    func getUser(params: GetUserParameters, completionHandler: @escaping GetUserUseCaseCompletionHandler)
}

struct GetUserParameters {
    let username: String
}

class GetUserUseCaseImpl: GetUserUseCase {
    
    let gateway: UserGateway
    
    init(gateway: UserGateway) {
        self.gateway = gateway
    }
    
    func getUser(params: GetUserParameters, completionHandler: @escaping GetUserUseCaseCompletionHandler) {
        self.gateway.getUser(params: params) { (result) in
            completionHandler(result)
        }
    }
    
}
