//
//  UserViewModel.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation

struct UserFormatter {
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func getId() -> Int {
        return self.user.id
    }
    
    func getUsername() -> String {
        guard let username = self.user.login else { return "" }
        
        return username
    }
    
    func getProfileUrl() -> String {
        guard let url = self.user.url else { return "" }
        
        return url
    }
    
    func getAvatarUrl() -> String {
        guard let url = self.user.avatarUrl else { return "" }
        
        return url
    }
    
    func hasNote() -> Bool {
        return self.user.note == nil ? false : true
    }
    
    func getNotes() -> String {
        guard let notes = self.user.note else { return "" }
        
        return notes
    }
    
    //
    
    func getName() -> String {
        guard let name = self.user.name else { return "" }
        
        return name
    }
    
    func getFormattedName() -> String {
        return "Name: \(getName())"
    }
    
    func getCompany() -> String {
        guard let company = self.user.company else { return "" }
        
        return company
    }
    
    func getFormattedCompany() -> String {
        return "Company: \(getCompany())"
    }
    
    func getBlog() ->  String {
        guard let blog = self.user.blog else { return "" }
        
        return blog
    }
    
    func getFormattedBlog() -> String {
        return "Blog: \(getBlog())"
    }
    
    func getFollowers() -> Int {
        guard let followers = self.user.followers else { return 0 }
        
        return followers
    }
    
    func getFormattedFollowers() -> String {
        return "Followers: \(getFollowers())"
    }
    
    func getFollowing() -> Int {
        guard let following = self.user.following else { return 0 }
        
        return following
    }
    
    func getFormattedFollowing() -> String {
        return "Following: \(getFollowing())"
    }
    
}
