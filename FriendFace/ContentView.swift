//
//  ContentView.swift
//  FriendFace
//
//  Created by Andrew on 23/11/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //@State private var users = [User(isActive: false, name: "Andrew", age: 33, company: "None", email: "andrew@example.com", address: "Somewhere", about: "Smells", registered: Date(), tags: ["none"], friends: [Friend]())]
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(self.users) { user in
                HStack {
                    Text("\(user.name)")
                }
            }.navigationBarTitle("Friend Face")
        } .onAppear(perform: GetUsers)
    }
    
    func GetUsers() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
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
