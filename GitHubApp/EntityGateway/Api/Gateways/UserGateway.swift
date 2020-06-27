//
//  UserGateway.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation

protocol ApiUserGateway: UsersGateway, UserGateway {
}

class ApiUserGatewayImpl: ApiUserGateway {
    
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func getUsers(params: GetUsersParameters, completionHandler: @escaping UsersEntityGatewayCompletionHandler) {
        
        let request = GetUsersApiRequest(params: params)
        
        self.apiClient.execute(request: request) {
            (result: Result<ApiResponse<[ApiUser]>, Error>) in
            
            switch result {
            case .success(let response):
                let users = response.entity.map { $0.user }
                completionHandler(.success(users))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
        
    }
    
    func getUser(params: GetUserParameters, completionHandler: @escaping UserEntityGatewayCompletionHandler) {
        
        let request = GetUserApiRequest(params: params)
        
        self.apiClient.execute(request: request) {
            (result: Result<ApiResponse<ApiUser>, Error>) in
            
            switch result {
            case .success(let response):
                let user = response.entity.user
                completionHandler(.success(user))
            case .failure(let error):
                completionHandler(.failure(error))
            }
            
        }
        
    }
    
}
