//
//  ContentView.swift
//  Edutainment
//
//  Created by Mathias on 7/12/23.
//

import SwiftUI

struct Question: View {
    var question: String
    var answer: String

    var body: some View {
        Text("what is \(question)")
    }
}

struct SettingsView: View {
    @State private var difficulty = 2
    @State private var questionAmount = 5
    @State private var questions = [String]()
    @State private var screen = "settings"
    
    var body: some View {
        if screen == "settings" {
            VStack(alignment: .leading, spacing: 0) {
                Form {
                    Stepper("Up to \(difficulty)", value: $difficulty, in: 2...12, step: 1)
                    
                    Text("Amount of questions you want to be asked:").font(.headline)
                    Picker("Amount of questions", selection: $questionAmount) {
                        ForEach(5..<21) {
                            if $0.isMultiple(of: 5) {
                                Text("\($0)")
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                    Button("Begin", action: startGame)
                    
                }
            }
        }
        if screen == "game" {
            VStack {
                ForEach(questions, id: \.self) {
                    Text($0)
                }
            }
        }
    }
    
    /**
     * @TODO: Replace with question/answer struct above:
     */
    func startGame() {
        var firstNumber = ""
        var secondNumber = ""
        var myQuestions = [String]()
        for i in 0..<difficulty+1 {
            for j in 0..<difficulty+1 {
                firstNumber = String(i)
                secondNumber = String(j)
                myQuestions.append("\(firstNumber) x \(secondNumber)")
            }
        }
        
        for _ in 0..<questionAmount {
            questions.append("What is \(myQuestions.randomElement() ?? "0 x 0")")
        }

        print(questions)
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Times Table")
                .font(.headline)
            SettingsView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
