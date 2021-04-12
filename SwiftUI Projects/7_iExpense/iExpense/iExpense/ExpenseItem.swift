//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Alex Luna on 12/04/2021.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}
