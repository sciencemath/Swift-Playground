//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mathias on 7/9/23.
//

import SwiftUI

//struct ContentView: View {
//    @State private var showingAlert = false
//    var body: some View {
//        Button("Show Alert") {
//            showingAlert = true
//        }.alert("Important message", isPresented: $showingAlert) {
//            Button("Delete", role: .destructive) { }
//            Button("Cancel", role: .cancel) { }
//        } message: {
//            Text("Please read this!")
//        }
//        AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
//        RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
//        LinearGradient(gradient: Gradient(stops: [
//            .init(color: .white, location: 0.45),
//            .init(color: .black, location: 0.55)
//        ]), startPoint: .top, endPoint: .bottom)
//        ZStack {
            //            Color.red
            //                .frame(minWidth: 200, maxWidth: .infinity, maxHeight: 200)
//            VStack(spacing: 0) {
//                Color.red
//                Color.blue
//            }
            
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//
//            Text("Hello, world!")
//                .foregroundStyle(.secondary)
//                .padding(50)
//                .background(.ultraThinMaterial)
//
//        }.ignoresSafeArea()
//    }
//}

struct FlagImage: View {
    var image: String
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var isShowingFinalScore = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of").font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer]).font(.largeTitle.weight(.semibold))
                    }.foregroundColor(.primary)
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(image: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }.padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Final Score", isPresented: $isShowingFinalScore) {
            Button("Reset", action: askQuestion)
        } message: {
            Text("Final score has been reached, reseting score")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong thats the flag of \(countries[number])"
            score = score > 0 ? score - 1 : 0
        }
        
        if score == 8 {
            checkScore()
            return
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func checkScore() {
        isShowingFinalScore = true
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
