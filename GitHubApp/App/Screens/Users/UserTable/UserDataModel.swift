//
//  UserDataModel.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/29/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation

protocol UserDataModel {
    var id: Int { get }
    var login: String? { get }
    var url: String? { get }
    var avatarUrl: String? { get }
    var note: String? { get set }
    
    var name: String? { get }
    var company: String? { get }
    var blog: String? { get }
    var followers: Int? { get }
    var following: Int? { get }
}
