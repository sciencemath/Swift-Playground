//
//  ContentView.swift
//  FriendFace
//
//  Created by Mathias on 7/18/23.
//

import SwiftUI

struct User: Codable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]

    struct Friend: Codable {
        var id: String
        var name: String
    }
}
        
struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users, id: \.id) { user in
                    NavigationLink {
                        UserDetail(user: user)
                    } label: {
                        HStack {
                            Color(user.isActive ? .green : .red)
                                .frame(width: 10, height: 10)
                                .clipShape(Circle())
                                .padding()
                            VStack(alignment: .leading) {
                                Text(user.name)
                                Text(user.company)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .task {
                if (!users.isEmpty) {
                    return
                }
                await loadData()
            }
        }
        
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            users = try decoder.decode([User].self, from: data)
        } catch {
            print("Decode error", error)
            return
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
