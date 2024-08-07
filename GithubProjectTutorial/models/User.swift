//
//  User.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 07/08/24.
//

import Foundation

struct User : Codable, Hashable {
    var login : String
    var avatarUrl : String
    var name : String?
    var location : String?
    var bio : String?
    var publicRepos: Int
    var pubilcGists  : Int
    var htmlUrl : String
    var following : Int
    var followers : Int
    var createdAt : String
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
        hasher.combine(createdAt)
    }
}
