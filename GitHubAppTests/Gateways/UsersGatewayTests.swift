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
    
    var sut: ApiUserGatewayImpl!
    
    override func setUp() {
        super.setUp()
        
        self.sut = makeSUT()
    }
    
    override class func tearDown() {
        super.tearDown()
        
    }
    
    func test_get_users_response() {
        
        let expectation = self.expectation(description: "Users Response Parse Expectation")
        
        let params = GetUsersParameters(since: 0)
        
        sut.getUsers(params: params) { (result) in
            
            switch result {
            case .success:
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func test_get_user_response() {
        
        let expectation = self.expectation(description: "User Response Parse Expectation")
        
        let params = GetUserParameters(username: "momo")
        
        sut.getUser(params: params) { (result) in
            
            switch result {
            case .success:
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        
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
    
    func test_get_user() {
        
        let apiClient = ApiClientMock()
        let sut = ApiUserGatewayImpl(apiClient: apiClient)
    
        let params = GetUserParameters(username: "momo")
        
        sut.getUser(params: params) { (_) in }
        
        XCTAssertTrue(apiClient.executeCalled)
        
        let getUserUrl = GetUserApiRequest(params: params)
        
        XCTAssertEqual(apiClient.inputRequest?.url, getUserUrl.urlRequest.url)
    }
    
    private func makeSUT() -> ApiUserGatewayImpl {
        
        let apiClient = ApiClientImpl(config: .default, logger: nil)
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
