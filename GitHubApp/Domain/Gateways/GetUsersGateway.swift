//
//  GetUsersGateway.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/26/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation

typealias UsersEntityGatewayCompletionHandler = (_ users: Result<[User], Error>) -> Void

protocol UsersGateway {
    func getUsers(params: GetUsersParameters, completionHandler: @escaping UsersEntityGatewayCompletionHandler)
}
