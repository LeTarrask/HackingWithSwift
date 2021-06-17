//
//  ContentView.swift
//  MacTechnique
//
//  Created by Alex Luna on 17/06/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var isEnabled = false

    @State private var birthDate = Date()

    var body: some View {
        VStack {
            Toggle(isOn: $isEnabled) {
                Text("Enable the flux capacitor")
            }
            .toggleStyle(SwitchToggleStyle())

            VStack(alignment: .leading) {
                Text("Select your birth date")
                DatePicker("Birth date", selection: $birthDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
            }

            VStack {
                ForEach(ControlSize.allCases, id: \.self) { size in
                    Button("Click Me") {
                        print("\(size) button pressed")
                    }
                    .controlSize(size)
                }
            }
            .padding()
        }
        .padding()
        .frame(maxWidth: 500)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
