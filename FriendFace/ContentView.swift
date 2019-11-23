//
//  ContentView.swift
//  FriendFace
//
//  Created by Andrew on 23/11/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(self.users) { user in
                NavigationLink(destination: DetailView(user: user)) {
                    HStack {
                        Text("\(user.name)")
                        Spacer()
                        Text("\(user.isActive ? "✅" : "")")
                    }
                }
            }.navigationBarTitle("Friend Face")
        } .onAppear(perform: GetUsers)
    }
    
    func GetUsers() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown Error").")
                return
            }

            if let decodedUsers = try? JSONDecoder().decode([User].self, from: data) {
                // back to the main thread
                DispatchQueue.main.async {
                    // update UI
                    self.users = decodedUsers
                }
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
