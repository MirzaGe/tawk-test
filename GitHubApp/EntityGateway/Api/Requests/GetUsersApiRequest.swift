//
//  GetUsersApiRequest.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation

struct GetUsersApiRequest: ApiRequest {
    
    let params: GetUsersParameters
    
    var urlRequest: URLRequest {
        
        let url: URL! = URL(string: "https://api.github.com/users?since=\(params.since)")
        var request = URLRequest(url: url)
        
        request.httpMethod = HTTPMethod.GET.rawValue
        
        return request
    }
    
}
