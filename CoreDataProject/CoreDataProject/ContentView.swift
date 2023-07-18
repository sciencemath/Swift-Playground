//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Mathias on 7/17/23.
//

import SwiftUI

//struct ContentView: View {
//    @Environment(\.managedObjectContext) var moc
//
//    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
//
//    var body: some View {
//        VStack {
//            List(wizards, id: \.self) { wizard in
//                Text(wizard.name ?? "Unknown")
//            }
//
//            Button("Add") {
//                let wizard = Wizard(context: moc)
//                wizard.name = "Harry Potter"
//            }
//
//            Button("Save") {
//                do {
//                    try moc.save()
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//        }
////        Button("Save") {
////            if moc.hasChanges {
////                try? moc.save()
////            }
////        }
//    }
//}

// "universe IN %@", ["Aliens", "Firefly", "Star Trek"]
// "name BEGINSWITH[c] %@"
//struct ContentView: View {
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "NOT name CONTAINS[c] %@", "E")) var ships: FetchedResults<Ship>
//
//    var body: some View {
//        VStack {
//            List(ships, id: \.self) { ship in
//                Text(ship.name ?? "Unknown name")
//            }
//
//            Button("Add Examples")  {
//                let ship1 = Ship(context: moc)
//                ship1.name = "Enterprise"
//                ship1.universe = "Star Trek"
//
//                let ship2 = Ship(context: moc)
//                ship2.name = "Defiant"
//                ship2.universe = "Star Trek"
//
//                let ship3 = Ship(context: moc)
//                ship3.name = "Millennium Falcon"
//                ship3.universe = "Star Wars"
//
//                let ship4 = Ship(context: moc)
//                ship4.name = "Executor"
//                ship4.universe = "Star Wars"
//
//                try? moc.save()
//            }
//        }
//    }
//}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    
    var body: some View {
        Text("Placeholder")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
