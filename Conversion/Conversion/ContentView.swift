//
//  ContentView.swift
//  Conversion
//
//  Created by Mathias on 7/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var fromConversion = "feet"
    @State private var toConversion = "feet"
    @State private var lowestUnitFeet = 0.0
    
    let inputConversions = ["meters", "kilometers", "feet", "yard", "miles"]
    
    var convertUnit: Double {
        var output = 0.0
        var feet = 0.0
        
        /**
            Maybe a better structure here would be using a dictionary w/ associated units? or a tuple!?
                ["yards": unit * 3, "meters": unit * 3.28 ... ]
            Something to ponder about.
         */
        
        switch fromConversion {
            case "feet": feet = lowestUnitFeet * 1
            case "yards": feet = lowestUnitFeet * 3
            case "meters": feet = lowestUnitFeet * 3.28
            case "kilometers": feet = lowestUnitFeet * 3280.84
            case "miles": feet = lowestUnitFeet * 5280
            default: feet = lowestUnitFeet * 1
        }
        
        switch toConversion {
            case "feet": output = feet / 1
            case "yards": output = feet / 3
            case "meters": output = feet / 3.28
            case "kilometers": output = feet / 3280.84
            case "miles": output = feet / 5280
            default: output = feet / 1
        }
        
        return output
    }
    
    var body: some View {
        VStack {
            Form {
                Section {
                    Picker("Convert From", selection: $fromConversion) {
                        ForEach(inputConversions, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("From:")
                }
                
                Section {
                    Picker("Convert To", selection: $toConversion) {
                        ForEach(inputConversions, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("To:")
                }
                
                Section {
                    TextField("Enter Unit", value: $lowestUnitFeet, format: .number)
                } header: {
                    Text("Input Units:")
                }

                Section {
                    Text(convertUnit, format: .number)
                } header: {
                    Text("Output:")
                }
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
