//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Mathias on 7/20/23.
// @TODO finish the rest of this ViewModel should resemble the one we built for ContentView
// 

import Foundation

extension ContentView {
    @MainActor class EditViewModel: ObservableObject {
        @Published var name = ""
        @Published var description = ""
        
        @Published private (set) var locations: [Location]
        
//        @Published var loadingState = LoadingState.loading
//        @Published var pages = [Page]()
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func createLocation(location: Location) -> Location {
            var newLocation = location
            newLocation.id = UUID()
            newLocation.name = name
            newLocation.description = description
            
            return newLocation
        }
    }
}
