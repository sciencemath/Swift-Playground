//
//  ContentView.swift
//  Flashzilla
//
//  Created by Mathias on 7/22/23.
//

import CoreHaptics
import SwiftUI

struct ContentView1: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onLongPressGesture(minimumDuration: 1) {
            print("Long pressed!")
        } onPressingChanged: { inProgress in
            print("In progress: \(inProgress)")
        }
//        .onTapGesture(count: 2) {
//            print("Double tapped")
//        }
    }
}

struct ContentView2: View {
//    @State private var currentAmount = 0.0
//    @State private var finalAmount = 1.0
    @State private var currentAmount = Angle.zero
    @State private var finalAmount = Angle.zero
    
    var body: some View {
        Text("Hello, world!")
//            .scaleEffect(finalAmount + currentAmount)
            .rotationEffect(currentAmount + finalAmount)
            .gesture(
//                MagnificationGesture()
                RotationGesture()
                    .onChanged { angle in
                        currentAmount = angle
//                        currentAmount = amount - 1
                    }
                    .onEnded { angle in
                        finalAmount += currentAmount
                        currentAmount = .zero
//                        currentAmount = 0
                    }
            )
    }
}

struct ContentView3: View {
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }
        
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        
        let combined = pressGesture.sequenced(before: dragGesture)
        
        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
        
//        VStack {
//            Text("Hello, world!")
//                .onTapGesture {
//                    print("Text tapped!") // child takes priority over parent unless highPriorityGesture
//                }
//        }
//        .highPriorityGesture(
//            TapGesture()
//                .onEnded {
//                    print("VStack tapped")
//                }
//        )
    }
}

struct ContentView4: View {
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Text("Hello")
            .onAppear(perform: prepareHaptics)
            .onTapGesture(perform: complexSuccess)
//            .onTapGesture(perform: simpleSuccess)
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Unable to create engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern \(error.localizedDescription)")
        }
    }
}

struct ContentView5: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }
            
            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
                .contentShape(Rectangle()) // hitarea
                .onTapGesture {
                    print("Circle tapped!")
                }
                .allowsHitTesting(false) // pass through
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            print("V")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
