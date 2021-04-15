//
//  SwiftUIView.swift
//  
//
//  Created by Alex Luna on 09/04/2021.
//

import SwiftUI

// Este struct recebe um Int para row e outro para column
// e uma closure que gera o conteúdo, baseada nesses dois valores
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0 ..< rows) { row in
                HStack {
                    ForEach(0 ..< columns) { column in
                        content(row, column)
                    }
                }
            }
        }
    }

    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
       self.rows = rows
       self.columns = columns
       self.content = content
    }
}

struct GridStack_Previews: PreviewProvider {
    static var previews: some View {
        var body: some View {
            GridStack(rows: 4, columns: 4) { row, col in
               Image(systemName: "\(row * 4 + col).circle")
               Text("R\(row) C\(col)")
            }
        }
    }
}
