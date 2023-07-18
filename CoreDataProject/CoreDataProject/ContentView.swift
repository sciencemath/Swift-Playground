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

// Using custom filter using the singer data
//struct ContentView: View {
//    @Environment(\.managedObjectContext) var moc
//    @State private var lastNameFilter = "A"
//
//    var body: some View {
//        VStack {
//            FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
//                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
//            }
//
//            Button("Add Examples") {
//                let taylor = Singer(context: moc)
//                taylor.firstName = "Taylor"
//                taylor.lastName = "Swift"
//
//                let ed = Singer(context: moc)
//                ed.firstName = "Ed"
//                ed.lastName = "Sheeran"
//
//                let adele = Singer(context: moc)
//                adele.firstName = "Adele"
//                adele.lastName = "Adkins"
//
//                try? moc.save()
//            }
//
//            Button("Show A") {
//                lastNameFilter = "A"
//            }
//
//            Button("Show S") {
//                lastNameFilter = "S"
//            }
//        }
//    }
//}

// using country -> candy relationship (many to one) from core data
struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    
    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(country.wrappedFullName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            
            Button("Add Examples") {
                let candy1 = Candy(context: moc)
                candy1.name = "PayDay"
                candy1.origin = Country(context: moc)
                candy1.origin?.shortName = "US"
                candy1.origin?.fullName = "United States"
                
                let candy2 = Candy(context: moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"
                
                let candy3 = Candy(context: moc)
                candy3.name = "Toblerone"
                candy3.origin = Country(context: moc)
                candy3.origin?.shortName = "CH"
                candy3.origin?.fullName = "Switzerland"
                
                let candy4 = Candy(context: moc)
                candy4.name = "Cuberdon"
                candy4.origin = Country(context: moc)
                candy4.origin?.shortName = "BE"
                candy4.origin?.fullName = "Belgium"
                
                let candy5 = Candy(context: moc)
                candy5.name = "Baby Ruth"
                candy5.origin = Country(context: moc)
                candy5.origin?.shortName = "US"
                candy5.origin?.fullName = "United States"
                
                try? moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
