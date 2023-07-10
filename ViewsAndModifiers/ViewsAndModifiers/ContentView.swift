//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Mathias on 7/10/23.
//

import SwiftUI

struct LargeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func largeBlueStyle() -> some View {
        modifier(LargeBlueTitle())
    }
}

struct CustomView: View {
    var text: String
    
    var body: some View {
        Text(text).largeBlueStyle()
    }
}


struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            CustomView(text: "Hello There!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
