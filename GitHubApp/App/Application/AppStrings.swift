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
    case errorTitle = "ERROR_TITLE"
    case okTitle = "OK_TITLE"
    case successTitle = "SUCCESS_TITLE"
    case noteAddedMessage = "NOTE_ADDED_MESSAGE"
    
    case offlineModeMessage = "OFFLINE_MODE_MESSAGE"
    case onlineModeMessage = "ONLINE_MODE_MESSAGE"
    
}

extension String {
    
    func getLocalize() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
