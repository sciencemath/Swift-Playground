//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Mathias on 7/18/23.
//
// @TODO Finish  https://www.hackingwithswift.com/books/ios-swiftui/core-data-wrap-up
//
// Modify the predicate string parameter to be an enum such as .beginsWith, then make that enum get resolved to a string inside the initializer (started it below).

// Make FilteredList accept an array of SortDescriptor objects to get used in its fetch request.


import CoreData
import SwiftUI

enum Predicate: String {
    case beginsWith = "BEGINSWITH"
    case startsWith = "STARTSWITH"
    case endsWith = "ENDSWITH"
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest(sortDescriptors: []) var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
//            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
    /**
     * Will re-run when state changes but will not re-load the data Core Data is smart enough to
     * only re-runs the request as long as the predicate hasn't changed
     *
     * Example usage:
     * FilteredList(filterKey: "lastName", filterValue: lastNameFilter, predicate: "BEGINSWITH")
     */
    init(filterKey: String, filterValue: String, predicate: String, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K \(predicate) %@", filterKey, filterValue))
        self.content = content
    }
}
