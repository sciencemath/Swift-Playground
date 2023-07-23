//
//  Prospect.swift
//  HotProspects
//
//  Created by Mathias on 7/22/23.
//
// @TODO Save JSON, and use a confirmation dialog to customize the way users are sorted in each tab – by name or by most recent.

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var email = ""
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    let saveKey = "SavedData"
    
    // let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
    // let data = try Data(contentsOf: savePath)
    // locations = try JSONDecoder().decode([Location].self, from: data)
    
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }
        
        // no saved data
        people = []
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send() // always before (might have animation) but also I think this is a batch process? <- good for a research topic.
        prospect.isContacted.toggle()
        save()
    }
}
