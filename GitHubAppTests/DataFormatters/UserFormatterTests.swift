//
//  UserFormatterTests.swift
//  GitHubAppTests
//
//  Created by John Roque Jorillo on 6/28/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import XCTest

@testable import GitHubApp

class UserFormatterTests: XCTestCase {

    var sut: UserFormatter!
    
    override func setUp() {
        super.setUp()
        
        sut = makeSUT()
    }
    
    override class func tearDown() {
        super.tearDown()
    }

    func test_get_id() {
        XCTAssertEqual(sut.getId(), 1)
    }
    
    func test_formatted_name() {
        XCTAssertEqual(sut.getFormattedName(), "Name: Tom Preston-Werner")
    }
    
    func test_formatted_company() {
        XCTAssertEqual(sut.getFormattedCompany(), "Company: ")
    }
    
    func test_formatted_blog() {
        XCTAssertEqual(sut.getFormattedBlog(), "Blog: http://tom.preston-werner.com")
    }
    
    func test_formatted_followers() {
        XCTAssertEqual(sut.getFormattedFollowers(), "Followers: 21917")
    }
    
    func test_formatted_following() {
        XCTAssertEqual(sut.getFormattedFollowing(), "Following: 11")
    }
    
    // MARK: - Helpers
    private func makeSUT() -> UserFormatter {
        let sut = UserFormatter(user: decodeStubbedUser()!)
        return sut
    }
    
    private func decodeStubbedUser() -> User? {
        
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
