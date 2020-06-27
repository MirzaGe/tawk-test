//
//  CDUser+CoreDataClass.swift
//  
//
//  Created by John Roque Jorillo on 6/27/20.
//
//

import Foundation
import CoreData

@objc(CDUser)
public class CDUser: NSManagedObject {

    func setData(user: User) {
        avatarUrl = user.avatarUrl
        bio = user.bio
        company = user.company
        createdAt = user.createdAt
        email = user.email
        eventsUrl = user.eventsUrl
        followers = Int32(exactly: NSNumber(integerLiteral: user.followers ?? 0)) ?? 0
        followersUrl = user.followersUrl
        following = Int32(exactly: NSNumber(integerLiteral: user.following ?? 0)) ?? 0
        login = user.login
        id = Int32(exactly: NSNumber(integerLiteral: user.id)) ?? 0
        nodeId = user.nodeId
        gravatarUrl = user.gravatarUrl
        url = user.url
        htmlUrl = user.htmlUrl
        gistsUrl = user.gistsUrl
        starredUrl = user.starredUrl
        subscriptionsUrl = user.subscriptionsUrl
        organizationsUrl = user.organizationsUrl
        reposUrl = user.reposUrl
        receivedEventsUrl = user.receivedEventsUrl
        type = user.type
        siteAdmin = user.siteAdmin ?? false
        name = user.name
        location = user.location
        hireable = user.hireable ?? false
        twitterUsername = user.twitterUsername
        publicRepos = Int32(exactly: NSNumber(integerLiteral: user.publicRepos ?? 0)) ?? 0
        publicGists = Int32(exactly: NSNumber(integerLiteral: user.publicGists ?? 0)) ?? 0
        updatedAt = user.updatedAt
    }
    
    var user: User {
        return User(login: login,
                    id: Int(id),
                    nodeId: nodeId,
                    avatarUrl: avatarUrl,
                    gravatarUrl: gravatarUrl,
                    url: url,
                    htmlUrl: htmlUrl,
                    followersUrl: followersUrl,
                    followingUrl: "",
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
                    publicRepos: Int(publicRepos),
                    publicGists: Int(publicGists),
                    followers: Int(followers),
                    following: Int(following),
                    createdAt: createdAt,
                    updatedAt: updatedAt,
                    note: "")
    }
    
}

extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var avatarUrl: String?
    @NSManaged public var bio: String?
    @NSManaged public var blog: String?
    @NSManaged public var company: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var email: String?
    @NSManaged public var eventsUrl: String?
    @NSManaged public var followers: Int32
    @NSManaged public var followersUrl: String?
    @NSManaged public var following: Int32
    @NSManaged public var login: String?
    @NSManaged public var id: Int32
    @NSManaged public var nodeId: String?
    @NSManaged public var gravatarUrl: String?
    @NSManaged public var url: String?
    @NSManaged public var htmlUrl: String?
    @NSManaged public var gistsUrl: String?
    @NSManaged public var starredUrl: String?
    @NSManaged public var subscriptionsUrl: String?
    @NSManaged public var organizationsUrl: String?
    @NSManaged public var reposUrl: String?
    @NSManaged public var receivedEventsUrl: String?
    @NSManaged public var type: String?
    @NSManaged public var siteAdmin: Bool
    @NSManaged public var name: String?
    @NSManaged public var location: String?
    @NSManaged public var hireable: Bool
    @NSManaged public var twitterUsername: String?
    @NSManaged public var publicRepos: Int32
    @NSManaged public var publicGists: Int32
    @NSManaged public var updatedAt: String?

}
