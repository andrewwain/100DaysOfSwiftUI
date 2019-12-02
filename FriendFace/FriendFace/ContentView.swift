//
//  ContentView.swift
//  FriendFace
//
//  Created by Andrew on 23/11/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var userDTOS = [UserDTO]()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>

    var body: some View {
        NavigationView {
            List(self.users, id: \.id) { user in
                NavigationLink(destination: DetailView(user: user)) {
                    HStack {
                        Text("\(user.wrappedName)")
                        Spacer()
                        Text("\(user.isActive ? "✅" : "")")
                    }
                }
            }
        }.navigationBarTitle("Friend Face")
        .onAppear(perform: GetUsers)
    }
    
    func GetUsers() {
        if self.users.count == 0 {
            print("Empty database - load remote users")
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    print("No data in response: \(error?.localizedDescription ?? "Unknown Error").")
                    return
                }

                if let decodedUsers = try? JSONDecoder().decode([UserDTO].self, from: data) {
                    // back to the main thread
                    DispatchQueue.main.async {
                        // update UI
                        print(decodedUsers)
                        
                        for userDTO in decodedUsers {
                            print("\(userDTO.name)")
                            let aUser = User(context: self.moc)
                            aUser.id = userDTO.id
                            aUser.isActive = userDTO.isActive
                            aUser.name = userDTO.name
                            aUser.age = Int16(userDTO.age)
                            aUser.company = userDTO.company
                            aUser.email = userDTO.email
                            aUser.address = userDTO.address
                            aUser.about = userDTO.about
                            aUser.registered = userDTO.registered
                            
                            for userFriend in userDTO.friends {
                                let friend = Friend(context: self.moc)
                                friend.id = userFriend.id
                                friend.name = userFriend.name
                                aUser.addToFriends(friend)
                            }
                            
                            print("\(String(describing: aUser.name))")
                        }
                        
                        try? self.moc.save()
                        //self.users = decodedUsers
                    }
                } else {
                    print("Invalid response from server")
                }
            }.resume()
        } else {
            print("Users database populated, using cached users")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
