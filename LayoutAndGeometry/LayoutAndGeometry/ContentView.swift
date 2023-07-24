//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Mathias on 7/24/23.
// TODO all challenges: https://www.hackingwithswift.com/100/swiftui/94

import SwiftUI

struct OuterView: View {
    var body: some View {
        Text("Top")
        InnerView()
            .background(.green)
        Text("Bottom")
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            
            GeometryReader { geo in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Global center \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        
                        print("Local center \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                        
                        print("Custom center \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                    }
            }
            .background(.orange)
            
            Text("Right")
        }
    }
}

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView1: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in
                        Double(position) * -10
                    }
            }
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)
    }
}

// @timcook and TIM COOK align Vertically center no matter the content below or above
struct ContentView2: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@timcook")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                
                Image("timcook")
                    .resizable()
                    .frame(width: 64, height: 64)
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
            }
            
            VStack {
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
                Text("TIM COOK")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
    }
}

struct ContentView3: View {
    var body: some View {
        Text("Consciousness")
            .background(.red)
            .offset(x: 100, y: 100)
//            .position(x: 100, y: 100)
    }
}

struct ContentView4: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Text("Organic Creatures")
                    .frame(width: geo.size.width * 0.9)
                    .background(.red)
            }
            .background(.green)
            
            Text("More text")
                .background(.blue)
        }
    }
}

struct ContentView5: View {
    var body: some View {
        OuterView()
            .background(.red)
            .coordinateSpace(name: "Custom")
    }
}

struct ContentView6: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(colors[index % 7])
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(1..<20) { num in
                    GeometryReader { geo in
                        Text("Number \(num)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                            .frame(width: 200, height: 200)
                    }
                    .frame(width: 200, height: 200)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
