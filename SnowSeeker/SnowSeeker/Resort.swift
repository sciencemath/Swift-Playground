//
//  Resort.swift
//  SnowSeeker
//
//  Created by Mathias on 7/25/23.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    // static let doesn't get created until referenced
//    static let example = (Bundle.main.decode("resorts.json") as [Resort])[0]
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}
