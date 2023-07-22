//
//  Prospect.swift
//  HotProspects
//
//  Created by Mathias on 7/22/23.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var email = ""
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        people = []
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send() // always before (might have animation) but also I think this is a batch process? <- good for a research topic.
        prospect.isContacted.toggle()
    }
}
