//
//  ContentView.swift
//  BucketList
//
//  Created by Mathias on 7/19/23.
//

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ContentView: View {
    let users = [
        User(firstName: "Mathias", lastName: "Lastname")
        User(firstName: "Hope", lastName: "Hopidos")
        User(firstName: "Nate", lastName: "Woopsie")
    ].sorted()
    
    var body: some View {
        List(users) { user in
            Text("\(user.firstName) \(user.lastName)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
