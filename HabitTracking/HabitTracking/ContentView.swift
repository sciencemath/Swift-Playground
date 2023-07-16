//
//  ContentView.swift
//  HabitTracking
//
//  Created by Mathias on 7/15/23.
//

import SwiftUI

// @TODO separate the below out into there respective files, and finish the rest of challenge
// wasn't clear on what should happen so we'll have to improvise. Day 47

class Activities: ObservableObject {
    @Published var activities = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "activities")
            }
        }
    }
}

struct Activity: Identifiable, Codable {
    var id = UUID()
    let title: String
    let description: String
    let count: Int
}

struct AddActivityView: View {
    @ObservedObject var activities: Activities
    @State private var title = ""
    @State private var description = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Decription", text: $description)
            }
            .toolbar {
                Button("Save") {
                    let activity = Activity(title: title, description: description, count: 0)
                    activities.activities.append(activity)
                    dismiss()
                }
            }
        }
    }
}

struct ContentView: View {
    @StateObject var items = Activities()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(items.activities) { activity in
                        VStack(alignment: .leading) {
                            Text("\(activity.title)").bold()
                            Text("\(activity.description)")
                        }
                        
                    }
                }
                .navigationTitle("Activity Progress")
                .toolbar {
                    Button("Add Activity") {
                        showingSheet.toggle()
                    }
                }
                .sheet(isPresented: $showingSheet) {
                    AddActivityView(activities: items)
                }
                
                VStack {
                    if items.activities.count == 0 {
                        Text("Add an Activity").font(.subheadline)
                            .frame(height: .infinity, alignment: .trailing)
                        Spacer()
                        
                    }
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
