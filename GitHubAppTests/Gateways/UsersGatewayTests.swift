//
//  UsersGatewayTests.swift
//  GitHubAppTests
//
//  Created by John Roque Jorillo on 6/28/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import XCTest

@testable import GitHubApp

class UsersGatewayTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
        
    }
    
    func test_get_users() {
        let apiClient = ApiClientMock()
        let sut = ApiUserGatewayImpl(apiClient: apiClient)
        
        let params = GetUsersParameters(since: 0)
        
        sut.getUsers(params: params) { (_) in }
        
        XCTAssertTrue(apiClient.executeCalled)
        
        let getUsersUrl = GetUsersApiRequest(params: params)
        
        XCTAssertEqual(apiClient.inputRequest?.url, getUsersUrl.urlRequest.url)
    }
    
    private func makeSUT() -> ApiUserGatewayImpl {
        
        let apiClient = ApiClientMock()
        let userGateway = ApiUserGatewayImpl(apiClient: apiClient)
        
        return userGateway
        
    }

}

class ApiClientMock: ApiClient {
    
    var inputRequest: URLRequest?
    var executeCalled = false
    
    func execute<T>(request: ApiRequest, completionHandler: @escaping (Result<ApiResponse<T>, Error>) -> Void) where T : Decodable {
        inputRequest = request.urlRequest
        executeCalled = true
        
    }
    
}
