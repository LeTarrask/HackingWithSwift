//
//  ContentView.swift
//  MacTechnique
//
//  Created by tarrask on 18/06/2021.
//

import SwiftUI

struct InputsView: View {
    @State private var isEnabled = false
    
    @State private var birthDate = Date()
    
    @State private var selection = 0
    
    var body: some View {
        VStack(alignment: .center) {
            // Web link that goes to browser
            Button("Visit Apple") {
                NSWorkspace.shared.open(URL(string: "https://www.apple.com")!)
            }
            .buttonStyle(LinkButtonStyle())
            .padding()
            
            // Custom toggle
            Toggle(isOn: $isEnabled) {
                Text("Enable the flux capacitor")
            }
            
            // Toggle style that's not custom
            Toggle(isOn: $isEnabled) {
                Text("Enable the flux capacitor")
            }
            .toggleStyle(SwitchToggleStyle())
            .padding()
            
            // Date Picker
            VStack(alignment: .center) {
                Text("Select your birth date")
                DatePicker("Select your birth date", selection: $birthDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
            }
            
            // Button sizes
            VStack {
                ForEach(ControlSize.allCases, id: \.self) { size in
                    Button("Click Me") {
                        print("\(size) button pressed")
                    }
                    .controlSize(size)
                }
            }
            .padding()
            
            // Picker and menu buttons
            // Normal
            Picker("Select an option", selection: $selection) {
                ForEach(0..<5) { number in
                    Text("Option \(number)")
                }
            }
            .padding()
            
            // Radio group picker style
            Picker("Select an option", selection: $selection) {
                ForEach(0..<5) { number in
                    Text("Option \(number)")
                }
            }
            .pickerStyle(RadioGroupPickerStyle())
            .padding()
            
            // Menu button
            MenuButton("Options") {
                Button("Order coffee") {
                    print("Get me an espresso!")
                }
                Button("Log out") {
                    print("TTFN")
                }
            }
            .padding()
            
            // Borderless pull down menu
            MenuButton("Options") {
                Button("Order coffee") {
                    print("Get me an espresso!")
                }
                Button("Log out") {
                    print("TTFN")
                }
            }
            .padding()
            .menuButtonStyle(BorderlessPullDownMenuButtonStyle())
            
            
            
        }.frame(width: 400, height: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        InputsView()
    }
}
