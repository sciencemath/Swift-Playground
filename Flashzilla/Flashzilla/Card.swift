//
//  Card.swift
//  Flashzilla
//
//  Created by Mathias on 7/23/23.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Whats the difference betwwen @State and @Published", answer: "@State updates current body, @Published waits for changes and announces to the world that its changed.")
}
