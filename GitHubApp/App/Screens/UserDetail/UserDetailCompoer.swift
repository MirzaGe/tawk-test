//
//  UserDetailCompoer.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation

final class UserDetailComposer {
    
    private init() {}
    
    static func composeWith() -> UserDetailViewController {
        
        let vc = UserDetailViewController.initFromNib()
        
        return vc
    }
    
}
