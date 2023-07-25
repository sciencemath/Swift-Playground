//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Mathias on 7/24/23.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Mathias")
            Text("Country: USA")
            Text("Language: Javascript")
        }
        .font(.title)
    }
}

struct ContentView1: View {
    @State private var selectedUser: User? = nil
    
    var body: some View {
        Text("Hello, world!")
            .onTapGesture {
                selectedUser = User()
            }
            .sheet(item: $selectedUser) { user in
                Text(user.id)
            }
    }
}

struct ContentView2: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        if sizeClass == .compact {
            VStack(content: UserView.init)
        } else {
            HStack(content: UserView.init)
        }
    }
}

struct ContentView: View {
    @State private var searchText = ""
    let allNames = ["Mathias", "Hope", "Nate", "Amy"]
    
    var body: some View {
        NavigationStack {
            List(filteredNames, id: \.self) {name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Let me Google it")
            .navigationTitle("Searching")
        }
    }
    
    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
