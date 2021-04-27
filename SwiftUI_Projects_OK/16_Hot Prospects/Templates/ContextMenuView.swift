//
//  ContextMenuView.swift
//  Hot Prospects
//
//  Created by Alex Luna on 14/04/2021.
//

import SwiftUI

struct ContextMenuView: View {
    @State private var backgroundColor = Color.red

    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(backgroundColor)

            Text("Change Color")
                .padding()
                .contextMenu {
                    Button(action: {
                        backgroundColor = .red
                    }) {
                        Text("Red")
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.red)
                    }
                    Button(action: {
                        backgroundColor = .green
                    }) {
                        Text("Green")
                    }
                    Button(action: {
                        backgroundColor = .blue
                    }) {
                        Text("Blue")
                    }
                }
        }

    }
}

struct ContextMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenuView()
    }
}
