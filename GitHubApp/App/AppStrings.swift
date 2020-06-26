//
//  AppStrings.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/26/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation

enum AppStrings: String {
    
    case usersScreenTitle = "USERS_SCREEN_TITLE"
    
}

extension String {
    
    func getLocalize() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
