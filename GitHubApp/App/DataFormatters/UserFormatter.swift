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
    
}
