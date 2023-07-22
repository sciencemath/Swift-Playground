//
//  ContentView.swift
//  PictureRemember
//
//  Created by Mathias on 7/21/23.
// @TODO https://www.hackingwithswift.com/guide/ios-swiftui/6/3/challenge
// eventually use .camera so we're not just importing exsisting photos

import PhotosUI
import SwiftUI

struct ContentView: View {
    @State var selectedItems: [PhotosPickerItem] = []
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        VStack {
            Button("Start Tracking Location") {
                self.locationFetcher.start()
            }
            Button("Read Location") {
                if let location = self.locationFetcher.lastKnownLocation {
                    print("Your location is \(location)")
                } else {
                    print("Your location is unknown")
                }
            }
            PhotosPicker(selection: $selectedItems,
                                 matching: .images) {
                        Text("Select Multiple Photos")
                    }
        }
        .padding()
    }
    
//    func saveImageToDisk() {
//        if let jpegData = image.jpegData(compressionQuality: 0.8) {
//            try? jpegData.write(to: saveURL, options: [.atomic, .completeFileProtection])
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
