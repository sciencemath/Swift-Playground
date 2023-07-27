//
//  ContentView.swift
//  Edutainment
//
//  Created by Mathias on 7/12/23.
//

import SwiftUI

class ScreenView: ObservableObject {
    @Published var screen = "settings"
}

class Questions: ObservableObject {
    @Published var questions = [Question]()
}

struct Question: Hashable {
    var id = UUID()
    var question: String
    var answer: Int
}

struct GameView: View {
    var view: ScreenView
    var questions: Questions
    
    @State private var score = 0
    @State private var currentQuestion = 0
    @State private var answer = ""
    
    @State private var isShowingEndGame = false
    
    var body: some View {
        VStack {
            Text(questions.questions[currentQuestion].question)
            TextField("Answer", text: $answer)

            Button("Submit Answer") {
                answer = ""
                
                if Int(answer) == questions.questions[currentQuestion].answer {
                    score += 1
                }
            
                
                if currentQuestion == questions.questions.count-1 {
                    currentQuestion = 0
                    isShowingEndGame = true
                    return
                }
                
                currentQuestion += 1
            }
        }
        .alert("Your score is: \(score)", isPresented: $isShowingEndGame) {
            Button("Restart", role: .cancel) {
                resetGame()
            }
        }
    }
    
    func resetGame() {
        currentQuestion = 0
        score = 0
        view.screen = "settings"
    }
}

struct SettingsView: View {
    var view: ScreenView
    var questions: Questions
    @State private var questionsStruct = [Question]()
    
    @State private var difficulty = 2
    @State private var questionAmount = 5
    
    @State private var screen = "settings"
    @State private var isShowingEndGame = false
    
    var body: some View {
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
    
    func startGame() {
        for _ in 0..<questionAmount+5 {
            let firstNumber = Int.random(in: 0...difficulty)
            let secondNumber = Int.random(in: 0...difficulty)
            questions.questions.append(
                Question(
                   question: "What is \(firstNumber) x \(secondNumber)",
                   answer: firstNumber * secondNumber
                 )
               )
        }
        
        view.screen = "game"
    }
}

struct ContentView: View {
    @ObservedObject var view = ScreenView()
    @ObservedObject var questions = Questions()
    
    var body: some View {
        VStack {
            Text("Times Table \(view.screen)")
                .font(.headline)
            if view.screen == "settings" {
                SettingsView(view: view, questions: questions)
            } else {
                GameView(view: view, questions: questions)
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
