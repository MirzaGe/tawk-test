//
//  CacheUsersGateway.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation

class CacheUsersGateway: UsersGateway, UserGateway {
    
    let apiUsersGateway: ApiUserGateway
    let localPersistence: CoreDataStackImplementation
    
    init(apiGateway: ApiUserGateway, localPersistence: CoreDataStackImplementation) {
        self.apiUsersGateway = apiGateway
        self.localPersistence = localPersistence
    }
    
    func getUsers(params: GetUsersParameters, completionHandler: @escaping UsersEntityGatewayCompletionHandler) {
        apiUsersGateway.getUsers(params: params) { [weak self] (result) in
            self?.handleGetUsersApiResult(result, shouldClear: params.since == 0, completionHandler: completionHandler)
        }
    }
    
    func getUser(params: GetUserParameters, completionHandler: @escaping UserEntityGatewayCompletionHandler) {
        self.apiUsersGateway.getUser(params: params) { [weak self] (result) in
            self?.handleGetUserApiResult(result,
                                         username: params.username,
                                         completionHandler: completionHandler)
        }
    }
    
}

extension CacheUsersGateway {
    
    fileprivate func handleGetUsersApiResult(_ result: Result<[User], Error>,
                                             shouldClear: Bool,
                                             completionHandler: @escaping UsersEntityGatewayCompletionHandler) {
        
        switch result {
        case .success(let users):
            // save
            if shouldClear {
                self.localPersistence.clearUsersStorage()
            }
            
            self.localPersistence.saveUsers(users: users)
            completionHandler(result)
        case .failure(_):
            if shouldClear { // means its since its 0 we can  get local data
                
                let users = self.localPersistence.getUsers().map { $0.user }
                completionHandler(.success(users))
            } else { // return empty
                completionHandler(.success([]))
            }
        }
        
    }
    
    fileprivate func handleGetUserApiResult(_ result: Result<User, Error>,
                                            username: String,
                                            completionHandler: @escaping UserEntityGatewayCompletionHandler) {
        
        switch result {
        case .success(let user): // savev new data
            self.localPersistence.updateUser(user: user)
            completionHandler(result)
        case .failure(_): // get local user
            let user = self.localPersistence.getUser(username: username)!.user // not safe please refactor
            completionHandler(.success(user))
        }
        
    }
    
}
