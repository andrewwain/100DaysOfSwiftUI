//
//  User+CoreDataProperties.swift
//  FriendFace
//
//  Created by Andrew on 25/11/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: String?
    @NSManaged public var tags: NSSet?
    @NSManaged public var friends: NSSet?

    var wrappedName: String {
        get {
            return name ?? "Unknown Name"
        }
    }
    
    var wrappedAbout: String {
        get {
            return about ?? "Bio missing"
        }
    }
    
    var wrappedAddress: String {
        get {
            return address ?? "Missing address"
        }
    }
    
    var wrappedEmail: String {
        get {
            return email ?? "Missing email"
        }
    }
    
    public var friendsArray: [Friend] {
        let set = friends as? Set<Friend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for tags
extension User {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}
