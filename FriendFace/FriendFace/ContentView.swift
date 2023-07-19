//
//  ContentView.swift
//  FriendFace
//
//  Created by Mathias on 7/18/23.
//
// @TODO Finish https://www.hackingwithswift.com/100/swiftui/61

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
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUser: FetchedResults<CachedUser>
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
                print("BEFORE MAINACTOR DONE!", cachedUser.count)
                await MainActor.run {
                    print("MAINACTOR DONE!", cachedUser.count)
                    for user in users {
                        let cachedUser1 = CachedUser(context: moc)
                        cachedUser1.id = user.id
                        cachedUser1.isActive = user.isActive
                        cachedUser1.name = user.name
                        cachedUser1.age = Int16(user.age)
                        cachedUser1.company = user.company
                        cachedUser1.email = user.email
                        cachedUser1.address = user.address
                        cachedUser1.about = user.about
                        cachedUser1.registered = user.registered
                        cachedUser1.tags = user.tags.joined(separator: ",")
                        cachedUser1.friend = CachedFriend(context: moc)
                        for friend in user.friends {
                            cachedUser1.friend?.name = friend.name
                            cachedUser1.friend?.id = friend.id
                        }
                        try? moc.save()
                    }
                }
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
