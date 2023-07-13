//
//  ContentView.swift
//  iExpense
//
//  Created by Mathias on 7/12/23.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String
    
    var body: some View {
        Text("Hello, \(name)!")
        Button("Dismiss") {
            dismiss()
        }
    }
}

// use with @State copys whole struct but efficiently
//struct User {
//    var firstName = "Bilbo"
//    var lastName = "Baggins"
//}

// use @Published with classes to expose values that need updating
// along side Type: ObservableObject
// and using: @StateObject var user = User() (not private its meant to be shared)
//class User: ObservableObject {
//    @Published var firstName = "Bilbo"
//    @Published var lastName = "Baggins"
//}

//struct ContentView2: View {
//    @StateObject var user = User()
//
//    var body: some View {
//        VStack {
//            Text("Your name is \(user.firstName) \(user.lastName)")
//
//            TextField("First name", text: $user.firstName)
//            TextField("Last name", text: $user.lastName)
//        }
//        .padding()
//    }
//}

struct ContentView3: View {
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "Mathias")
        }
    }
}

struct ContentView4: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .navigationTitle("onDelete()")
            .toolbar {
                EditButton()
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentView5: View {
//    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @AppStorage("tapCount") private var tapCount = 0
    
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
//            UserDefaults.standard.set(tapCount, forKey: "Tap")
        }
    }
}

struct User: Codable {
    let firstName: String
    let lastName: String
}

struct ContentView6: View {
    @State private var user = User(firstName: "Mathias", lastName: "Happy")
    
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name).font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: "USD"))
                    }
//                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
//                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
//                    expenses.items.append(expense)
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
