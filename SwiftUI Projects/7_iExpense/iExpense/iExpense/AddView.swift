//
//  AddView.swift
//  iExpense
//
//  Created by Alex Luna on 12/04/2021.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses

    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    static let types = ["Business", "Personal"]

    @State private var wrongInput = false

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0) }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
                    .navigationBarTitle("Add new expense")
            }
            
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(amount) {
                    let item = ExpenseItem(name: name, type: type,
                                           amount: actualAmount)
                    expenses.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                } else {
                    wrongInput = true
                }
            })
        }.alert(isPresented: $wrongInput, content: {
            Alert(title: Text("Wrong Input"), message: Text("Value should be a number"), dismissButton: .cancel(Text("OK")))
        })
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
