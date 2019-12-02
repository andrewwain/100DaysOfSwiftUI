//
//  User.swift
//  FriendFace
//
//  Created by Andrew on 23/11/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation

struct UserDTO: Codable, Identifiable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [FriendDTO]
}
