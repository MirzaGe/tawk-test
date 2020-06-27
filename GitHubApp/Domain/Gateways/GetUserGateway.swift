//
//  GetUserGateway.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation

typealias UserEntityGatewayCompletionHandler = (_ users: Result<User, Error>) -> Void

protocol UserGateway {
    func getUser(params: GetUserParameters, completionHandler: @escaping UserEntityGatewayCompletionHandler)
}
