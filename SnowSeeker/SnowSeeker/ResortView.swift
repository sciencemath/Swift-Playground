//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Mathias on 7/25/23.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize
    
    @EnvironmentObject var favorites: Favorites
    
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomLeading) {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    Spacer()
                    Spacer()
                    Text("Credit: \(resort.imageCredit)")
                        .background(.black.opacity(0.8))
                        .foregroundColor(.white)
                        .padding()
                }
                
                HStack {
                    if sizeClass == .compact && typeSize > .large {
                        VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }

                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge) // don't support text larger than xxxLarge, example: accessibility fonts could get very large (do you best to support the most you can)
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    
                    Button(favorites.contains(resort) ? "Remove from favorites" : "Add to favorites") {
                        if favorites.contains(resort) {
                            favorites.remove(resort)
                        } else {
                            favorites.add(resort)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    
//                    Text(resort.facilities.joined(separator: ", "))
//                    Text(resort.facilities, format: .list(type: .or))
                    // A way to have a comma seperated list appending the word "and" to the last one.
//                    Text(resort.facilities, format: .list(type: .and))
//                        .padding(.vertical)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "More Information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
            } message: { facility in
            Text(facility.description)
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ResortView(resort: Resort.example)
        }
        .environmentObject(Favorites())
    }
}
