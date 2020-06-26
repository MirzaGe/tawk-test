//
//  ApiUser.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/26/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation

struct ApiUser: Codable {
    
    let login: String?
    let id: Int
    let nodeId: String?
    let avatarUrl: String?
    let gravatarUrl: String?
    let url: String?
    let htmlUrl: String?
    let followersUrl: String?
    let followingUrl: String?
    let gistsUrl: String?
    let starredUrl: String?
    let subscriptionsUrl: String?
    let organizationsUrl: String?
    let reposUrl: String?
    let eventsUrl: String?
    let receivedEventsUrl: String?
    let type: String?
    let siteAdmin: Bool?
    
    let name: String?
    let company: String?
    let blog: String?
    let location: String?
    let email: String?
    let hireable: Bool?
    let bio: String?
    let twitterUsername: String?
    let publicRepos: Int?
    let publicGists: Int?
    let followers: Int?
    let following: Int?
    let createdAt: String?
    let updatedAt: String?
    
    let note: String?
    
}

extension ApiUser {
    
    var user: User {
        return User(login: login,
                    id: id,
                    nodeId: nodeId,
                    avatarUrl: avatarUrl,
                    gravatarUrl: gravatarUrl,
                    url: url,
                    htmlUrl: htmlUrl,
                    followersUrl: followersUrl,
                    followingUrl: followingUrl,
                    gistsUrl: gistsUrl,
                    starredUrl: starredUrl,
                    subscriptionsUrl: subscriptionsUrl,
                    organizationsUrl: organizationsUrl,
                    reposUrl: reposUrl,
                    eventsUrl: eventsUrl,
                    receivedEventsUrl: receivedEventsUrl,
                    type: type,
                    siteAdmin: siteAdmin,
                    name: name,
                    company: company,
                    blog: blog,
                    location: location,
                    email: email,
                    hireable: hireable,
                    bio: bio,
                    twitterUsername: twitterUsername,
                    publicRepos: publicRepos,
                    publicGists: publicGists,
                    followers: followers,
                    following: following,
                    createdAt: createdAt,
                    updatedAt: updatedAt,
                    note: note)
    }
    
}
