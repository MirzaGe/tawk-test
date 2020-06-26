//
//  UsersScreenComposer.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/26/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation

final class UsersScreenComposer {
    
    private init() {}
    
    static func composeWith() -> UsersViewController {
        
        let apiLogger = ApiLogger()
        let apiClient = ApiClientImpl(config: .default, logger: apiLogger)
        let apiGateway = ApiUserGatewayImpl(apiClient: apiClient)
        
        let getUsersUseCase = GetUsersUseCaseImpl(gateway: apiGateway)
        
        let vm = UsersViewModel(getUsersUseCase: getUsersUseCase)
        
        let vc = UsersViewController()
        vc.viewModel = vm
        
        return vc
    }
    
}
