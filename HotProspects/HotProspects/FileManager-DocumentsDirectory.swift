//
//  FileManager-DocumentsDirectory.swift
//  HotProspects
//
//  Created by Mathias on 7/22/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
