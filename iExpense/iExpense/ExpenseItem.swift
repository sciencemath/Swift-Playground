//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Mathias on 7/12/23.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
