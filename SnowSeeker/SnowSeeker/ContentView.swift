//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Mathias on 7/24/23.
//

import SwiftUI


/**
 * usage on a view for a viewModifier:
 * .phoneOnlyNavigationView()
 * Force non-adaptive layout which is not needed because of the comment below.
 */
extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

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

struct ContentView3: View {
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

/**
 * NavigationView is depracated no longer does it adapt by default (which is a good thing in my opinion)
 * using NavigationStack and if necessary could use NavigationSplitView where it mimiced the old behavior
 * but for our purposes and for future it makes sense to just stick with NavigationStack.
 */
struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
        }
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
