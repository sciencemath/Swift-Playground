//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Mathias on 7/10/23.
//
// Requirements:
// If computer chooses Rock and Win, you as a player should Win by choosing Paper
// If computer chooses Paper and Win, you as a player should Win by choosing Scissors
// If computer chooses Scissors and Lose, you as a player should Lose by choosing Paper
// etc.

import SwiftUI

struct ContentView: View {
    @State private var currentChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var round = 1
    @State private var shouldShowScoreAlert = false
    let choices = ["rock", "paper", "scissors"]
    
    var body: some View {
        VStack {
            Spacer()
            Text("Win or Lose: \(shouldWin ? "Win" : "Lose")")
            Text("Choice: \(choices[currentChoice])")
            HStack {
                Button("🪨") {
                    runGameLogic("rock")
                }.font(.system(size: 40))
                Button("📄") {
                    runGameLogic("paper")
                }.font(.system(size: 40))
                Button("✂️") {
                    runGameLogic("scissors")
                }.font(.system(size: 40))
            }
            Spacer()
            Text("Player score: \(score)")
        }
        .alert("Score:", isPresented: $shouldShowScoreAlert) {
            Button("Ok") { score = 0 } // reset score
        } message: {
            Text("\(score)")
        }
        .padding()
    }
    
    func runGameLogic(_ choice: String) {
        guard round < 10 else {
            resetGame()
            return
        }
        let computerChoice = choices[currentChoice]
        
        /**
         * This could be cleaned up by using switch, but maybe theres even a better way than that!
         */
        if (choice == "rock" && computerChoice == "scissors") { score += shouldWin ? 1 : -1 }
        if (choice == "rock" && computerChoice == "paper") { score += shouldWin ? -1 : 1 }
        if (choice == "scissors" && computerChoice == "paper") { score += shouldWin ? 1 : -1 }
        if (choice == "scissors" && computerChoice == "rock") { score += shouldWin ? -1 : 1 }
        if (choice == "paper" && computerChoice == "rock") { score += shouldWin ? 1 : -1 }
        if (choice == "paper" && computerChoice == "scissors") { score += shouldWin ? -1 : 1 }
        
        if score < 0 { score = 0 } // shouldn't see a negative score.
        
        chooseRandomComputedValues()
        round += 1
    }
    
    func chooseRandomComputedValues() {
        currentChoice = Int.random(in: 0..<3)
        shouldWin.toggle()
    }
    
    func resetGame() {
        shouldShowScoreAlert = true
        round = 0
        chooseRandomComputedValues()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
