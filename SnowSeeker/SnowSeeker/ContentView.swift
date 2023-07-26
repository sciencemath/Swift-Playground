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

enum SortDirection {
    case defaultOrder
    case alphabeticalOrder
    case countryOrder
}

/**
 * NavigationView is depracated no longer does it adapt by default (which is a good thing in my opinion)
 * using NavigationStack and if necessary could use NavigationSplitView where it mimiced the old behavior
 * but for our purposes and for future it makes sense to just stick with NavigationStack.
 */
struct ContentView: View {
    var resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var sortDirection: SortDirection = .defaultOrder
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    @State private var clicks = 0
    
    var sortDirectionText: String {
        switch sortDirection {
        case .defaultOrder:
            return "Default"
        case .countryOrder:
            return "Country"
        case .alphabeticalOrder:
            return "Alphabetical"
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Current: \(sortDirectionText) sort") {
                    clicks += 1
                    if clicks == 1 {
                        sortDirection = .countryOrder
                    } else if clicks == 2 {
                        sortDirection = .alphabeticalOrder
                    } else {
                        clicks = 0
                        sortDirection = .defaultOrder
                    }
                }
                List(filteredResorts) { resort in
                    NavigationLink {
                        ResortView(resort: resort)
                    } label: {
                        HStack {
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
                            
                            if favorites.contains(resort) {
                                Spacer()
                                Image(systemName: "heart.fill")
                                    .accessibilityLabel("This is a favorite")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .navigationTitle("Resorts")
                .searchable(text: $searchText, prompt: "Search for a resort")
            }
            .environmentObject(favorites)
        }
        
        var filteredResorts: [Resort] {
            var sortedResorts = resorts
            
            switch sortDirection {
            case .defaultOrder:
                break
            case .countryOrder:
                sortedResorts.sort { $0.country < $1.country }
            case .alphabeticalOrder:
                sortedResorts.sort { $0.name < $1.name }
            }
            
            if (!searchText.isEmpty) {
                return sortedResorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            } else {
                return sortedResorts
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
