//
//  ContentView.swift
//  WeSplit
//
//  Created by Alex Luna on 09/04/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]

    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        return orderAmount + tipValue
    }

    var totalPerPerson: Double {
        let people = Double(numberOfPeople) ?? 1
//        let peopleCount =  people + 2
        let amountPerPerson = grandTotal / people

        // Commented text were code deleted for challenge #3
        return amountPerPerson
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Add the bill to be split")) {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("People", text: $numberOfPeople)
                        .keyboardType(.numberPad)
//                    Picker("Number of people", selection: $numberOfPeople) {
//                        ForEach(2 ..< 100) {
//                            Text("\($0) people")
//
//                        }
//                    }
                }
                Section(header: Text("How much tip do you want to leave?")) {
                   Picker("Tip percentage", selection: $tipPercentage) {
                      ForEach(0 ..< tipPercentages.count) {
                         Text("\(self.tipPercentages[$0])%")
                      }
                   }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Total Check Value")) {
                   Text("$\(checkAmount)")
                    .foregroundColor(tipPercentage == 4 ? .red : .black)
                }
                Section(header: Text("Amount per person")) {
                   Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
