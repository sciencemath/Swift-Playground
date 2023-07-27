//
//  AddView.swift
//  iExpense
//
//  Created by Mathias on 7/12/23.
//

import SwiftUI

class ExpenseType: ObservableObject {
    @Published var personal = [ExpenseItem]()
    @Published var business = [ExpenseItem]()
}

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let typer: ExpenseType
    
//    @ObservedObject var typer = ExpenseType()
//    @ObservedObject var business = [ExpenseItem]()
    
    let types = ["Business", "Personal"]
    let userCurrency = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: userCurrency))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    separateLists(item)
                    dismiss()
                }
            }
        }
    }
    
    func separateLists(_ item: ExpenseItem) {
        if item.type == "Personal" {
            typer.personal.append(item)
        } else {
            typer.business.append(item)
        }
    }
}

//struct AddView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddView(expenses: Expenses())
//    }
//}
