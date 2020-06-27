//
//  CacheUsersGateway.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation

class CacheUsersGateway: UsersGateway {
    
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
            
            print(" saving to local ")
            
            self.localPersistence.saveUsers(users: users)
            completionHandler(result)
        case .failure(_):
            if shouldClear { // means its since its 0 we can  get local data
                print(" load from local ")
                
                let users = self.localPersistence.getUsers().map { $0.user }
                completionHandler(.success(users))
            }
        }
        
    }
    
}
