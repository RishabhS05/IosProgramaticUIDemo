//
//  Follower.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 07/08/24.
//

import Foundation

struct Follower  : Codable ,Hashable{
    var login : String
    var avatarUrl : String
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
}
