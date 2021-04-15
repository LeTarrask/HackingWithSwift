//
//  ContentView.swift
//  iExpense
//
//  Created by Alex Luna on 12/04/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()

    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            VStack {
                Button("Add expense") {
                    showingAddExpense = true
                }
                List {
                    ForEach(expenses.items) { item in
                        ZStack {
                            Rectangle()
                                .fill(
                                    item.amount > 10 ? (item.amount > 100 ? Color.red : Color.blue) : Color.green
                                )
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                Spacer()
                                Text("$\(item.amount)")
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }

                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: expenses)
                }
                .toolbar {
                    EditButton()
                }
                .navigationBarTitle("iExpense")
            }
//            .navigationBarItems(trailing:
//                                    Button(action: {
//                                        showingAddExpense = true
//                                    }) {
//                                        Image(systemName: "plus")
//                                    }
//            )
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
