//
//  DetailView.swift
//  FriendFace
//
//  Created by Andrew on 23/11/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var user: User
    
    var body: some View {
        Form {
            Section(header: Text("Details")) {
                Text("Status: \(user.isActive == true ? "Active" : "Not active")")
                
                Text(user.email)
                Text(user.address)
                Text(user.about)
            }
            
            Section(header: Text("Friends")) {
                List(user.friends) { friend in
                    Text(friend.name)
                }
            }
        }.navigationBarTitle(user.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(user: User(id: "test", isActive: false, name: "Andrew", age: 33, company: "None", email: "andrew@example.com", address: "somewhere", about: "bio", registered: "2019-12-14T01:33:22", tags: ["some tags"], friends: [Friend]()))
    }
}
