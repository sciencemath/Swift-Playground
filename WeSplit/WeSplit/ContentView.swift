//
//  ContentView.swift
//  WeSplit
//
//  Created by Mathias on 7/8/23.
//

import SwiftUI

//struct ContentView: View {
//    @State private var tapCount = 0
//    @State private var name = ""
//    let students = ["Harry", "Hermione", "Ron"]
//    @State private var selectedStudent = "Harry"
//
//    var body: some
//    View {
//        VStack {
//            ForEach(0..<10) {
//                Text("Row \($0)")
//            }
//            NavigationView {
//                Form {
//                    Picker("Select your student", selection: $selectedStudent) {
//                        ForEach(students, id: \.self) {
//                            Text($0)
//                        }
//                    }
//                    TextField("Enter your name", text: $name)
//                    Text("Hello there! \(name)")
//                    ForEach(0..<100) {
//                        Text("Row \($0)")
//                    }
//                    Section {
//                        Image(systemName: "globe")
//                            .imageScale(.large)
//                            .foregroundColor(.accentColor)
//                        Text("Hello, world!")
//                    }
//                    Group {
//                        Text("Hello, world!")
//                        Text("Hello, world!")
//                        Text("Hello, world!")
//                        Text("Hello, world!")
//                        Text("Hello, world!")
//                        Text("Hello, world!")
//                        Text("Hello, world!")
//                        Text("Hello, world!")
//                    }
//                }
//                .navigationTitle("Hello")
//                .navigationBarTitleDisplayMode(.inline)
//            }
//            Button("Tap Count: \(tapCount)") {
//                tapCount += 1
//            }
//
//        }
//        .padding()
//    }
//}

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let userCurrency = Locale.current.currency?.identifier ?? "USD"
    
    
    let tipPercentages = Range(0...100)
    
    var totalPlusTip: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        // calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some
    View {
        VStack {
            NavigationStack {
                Form {
                    Section {
                        TextField("Amount", value: $checkAmount, format:
                                .currency(code: userCurrency))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        
                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2..<100) {
                                Text("\($0) people")
                            }
                        }
                    }
                    
                    Section {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }.pickerStyle(.navigationLink) // .segmentated when a few values present
                    } header: {
                        Text("Percentage to leave?")
                            .lineLimit(1)
                    }
                    
                    Section {
                        Text(totalPerPerson, format: .currency(code: userCurrency))
                    } header: {
                        Text("Amount per person")
                            .lineLimit(1)
                    }
                    
                    Section {
                        Text(totalPlusTip, format: .currency(code: userCurrency))
                            .foregroundColor(tipPercentage == 0 ? .red : .black)
                    } header: {
                        Text("Total Amount + Tip:")
                    }
                }
                .navigationTitle("WeSplit")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
            }
        }.padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
