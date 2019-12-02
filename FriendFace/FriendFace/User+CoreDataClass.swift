//
//  User+CoreDataClass.swift
//  FriendFace
//
//  Created by Andrew on 25/11/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Identifiable {

}
    

extension CodingUserInfoKey {
   static let context = CodingUserInfoKey(rawValue: "context")
}
