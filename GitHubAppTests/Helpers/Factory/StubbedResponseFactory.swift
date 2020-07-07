//
//  StubbedResponseFactory.swift
//  GitHubAppTests
//
//  Created by John Roque Jorillo on 7/7/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation

@testable import GitHubApp

class StubbedResponseFactory {
    
    static func getStubbedUser() -> User? {
        
        if let path = Bundle.main.url(forResource: "User", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path)
                let user = try JSONDecoder.snakeToCamelcase.decode(ApiUser.self, from: data)
                return user.user
            } catch {
            }
        }
        
        return nil
        
    }
    
}
